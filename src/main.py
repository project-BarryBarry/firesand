import hashlib
import json
import os

import gdown
import requests as requests


# fetch json from GitHub
def get_download_info():
    url = 'https://raw.githubusercontent.com/project-BarryBarry/firesand/main/download.json?04251917'
    return json.loads(requests.get(url).text)


plugins = get_download_info()

# for each plugin, download and extract
for plugin in plugins:
    url = plugin['url']
    name = plugin['name']
    author = plugin['author']
    print('Downloading ' + name + ' by ' + author)
    gdown.download(url, name + '.deb', quiet=False, fuzzy=True)
    # check sha3 hash
    if hashlib.sha3_512(open(name + '.deb', 'rb').read()).hexdigest() != plugin['hash']:
        print('Hash mismatch, aborting')
        exit()
    # install deb
    os.system('sudo apt install --yes ./' + name + '.deb')
    # remove deb
    os.remove(name + '.deb')


