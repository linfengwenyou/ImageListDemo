
#coding = utf-8
import urllib
import re

def getHtml(url):
    page = urllib.urlopen(url)
    html = page.read()
    return html

def getImg(html):
    reg = 'src="(.+?\.jpg)" alt='
    imgre = re.compile(reg)
    imglist = re.findall(imgre, html)
    x = 0
    for imgurl in imglist:
        print imgurl
        urllib.urlretrieve(imgurl, '%s.jpg' % x)
        x+=1
#    return imglist

html = getHtml("http://www.ivsky.com/bizhi/fade_to_silence_v46081/")

print getImg(html)

