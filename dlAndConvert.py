# -*- coding: utf-8 -*-
"""
Created on Fri Mar 20 14:22:46 2015

@author: imaadumar
"""

import subprocess
import os
import shutil
import pandas

data = pandas.read_csv('neutral.csv')
numberOfLinks = len(data)


os.chdir('downloadedVideos')
for i in range(numberOfLinks):
    print ('\033[94m'+ "Downloading video " + str(i) + " out of " + str(numberOfLinks)+'\033[0m')
    url = data.iloc[i][0] 
    subprocess.call("youtube-dl " + url,shell=True)
    

os.chdir('..')
fileList = os.listdir('downloadedVideos');

os.chdir('convertedVideos')
for i in range(numberOfLinks +1):  #.DS_store is found due to mac file system so i++
    if not fileList[i].startswith('.'):    
        startTime = data.iloc[i-1][1]
        endTime = startTime + data.iloc[i-1][2]
        print ('\033[94m'+"Converting " + str(i) + " out of " + str(numberOfLinks)+'\033[0m')
        subprocess.call("/Applications/VLC.app/Contents/MacOS/VLC -I dummy --sout '#transcode{acodec=s16l,channels=2}:std{access=file,mux=wav,dst="+ str(i) + ".wav}' '"+"../downloadedVideos/"+fileList[i]+"' --start-time "+str(startTime)+" --stop-time "+str(endTime)+" vlc://quit",shell=True)
        
os.chdir('..')

print "***********Complete**************"