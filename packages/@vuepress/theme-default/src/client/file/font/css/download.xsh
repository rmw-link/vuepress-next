#!/usr/bin/env xonsh
from fire import Fire
from os.path import dirname,abspath,join
import traceback

ROOT = dirname(abspath(__file__))
@Fire
def main(outName, cssFile):
  cd @(ROOT)

  li = $(cat @(cssFile)|grep url)

  def line_url(i):
    i = i.strip()
    if not i:
      return i
    url = i.split("(")[1].split(")")[0]
    return url

  filemap = {}
  for i in li.split("\n"):
    url = line_url(i)
    if not url:
      continue

    download_url = url.strip('"\'')
    if download_url.startswith("//"):
      download_url = "https:"+download_url
    print(download_url)
    cd @(ROOT)/woff2
    wget -c @(download_url)
    filemap[url]=download_url.split("/").pop()

  fontFamily = cssFile[:-4].replace("-"," ")
  outLi = []
  with open(join(ROOT,cssFile)) as f:
    for i in f:
      if "url(" in i:
        url = line_url(i)
        i = i.replace(
            url,
            "\"~/file/font/css/woff2/"+filemap[url]+'"')
      outLi.append(i.replace(fontFamily, outName))

  with open(join(ROOT,outName),"w") as f:
    f.write("\n".join(outLi))
