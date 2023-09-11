import hashlib
import json
import os

import gdown
import requests as requests


# fetch json from GitHub
def get_download_info():
    url = 'https://raw.githubusercontent.com/project-BarryBarry/firesand/main/download.json?meaningless=ign_cache'
    return json.loads(requests.get(url).text)


plugins = get_download_info()

# for each plugin, download and extract
for plugin in plugins:
    url = plugin['url']
    name = plugin['name']
    author = plugin['author']
    without_postinst = plugin['without_postinst']
    print('Downloading ' + name + ' by ' + author)
    gdown.download(url, name + '.deb', quiet=False, fuzzy=True)
    # check sha3 hash
    if hashlib.sha3_512(open(name + '.deb', 'rb').read()).hexdigest() != plugin['hash']:
        print('Hash mismatch, ignore!')
        exit()
    # install deb
    if without_postinst:
        os.system('sudo dpkg --unpack ' + name + '.deb')
        os.system('sudo rm /var/lib/dpkg/info/' + name + '.postinst')
        os.system('sudo dpkg --configure ' + name)
        os.system("sudo apt-get install -fy")
    else:
        os.system('sudo apt install --yes ./' + name + '.deb')
    # remove deb
    os.remove(name + '.deb')
