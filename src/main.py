import os

import gdown
import json
import hashlib
import requests as requests


# fetch json from github
def get_download_info():
    url = 'https://raw.githubusercontent.com/username/repo/master/download.json'
    return json.loads(requests.get(url).text)


plugins = get_download_info()

# for each plugin, download and extract
for plugin in plugins:
    url = plugin['url']
    name = plugin['name']
    author = plugin['author']
    print('Downloading ' + name + ' by ' + author)
    gdown.download(url, name + '.deb', quiet=False)
    # check sha3 hash
    if hashlib.sha3_512(open(name + '.deb', 'rb').read()).hexdigest() != plugin['hash']:
        print('Hash mismatch, aborting')
        exit()
    # install deb
    os.system('apt install ' + name + '.deb')
    # remove deb
    os.remove(name + '.deb')


