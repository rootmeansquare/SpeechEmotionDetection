# -*- coding: utf-8 -*-
"""
Created on Fri Mar 20 14:22:46 2015

@author: imaadumar
"""

import subprocess
import os
import shutil
import pandas

fileList = [ ]

       
       
'''       
for root,parts,files in os.walk('/Users/imaadumar/Downloads/enterface database'):
    for name in files:
        if name.endswith('.avi'):
            print root + '/' + name
            subprocess.call("/Applications/VLC.app/Contents/MacOS/VLC -I dummy --sout '#transcode{acodec=s16l,channels=2}:std{access=file,mux=wav,dst="+ root + "/" + name[:-4] +".wav}' '"+ root + "/" + name +"' vlc://quit",shell=True)    
'''

for root,parts,files in os.walk('/Users/imaadumar/Downloads/enterface database'):
    for name in files:
        if name.endswith('.avi'):
            print root + '/' + name
            subprocess.call("/Applications/VLC.app/Contents/MacOS/VLC -I dummy --sout '#transcode{acodec=s16l,channels=2}:std{access=file,mux=wav,dst=/Users/imaadumar/Documents/Projects/ConvertedAudio" + name[:-4] +".wav}' '"+ root + "/" + name +"' vlc://quit",shell=True)    


'''for i in range(numberOfLinks +1):  #.DS_store is found due to mac file system so i++
    if not fileList[i].startswith('.'):    
        startTime = data.iloc[i-1][1]
        endTime = startTime + data.iloc[i-1][2]
        print ('\033[94m'+"Converting " + str(i) + " out of " + str(numberOfLinks)+'\033[0m')
        subprocess.call("/Applications/VLC.app/Contents/MacOS/VLC -I dummy --sout '#transcode{acodec=s16l,channels=2}:std{access=file,mux=wav,dst="+ str(i) + ".wav}' '"+"../downloadedVideos/"+fileList[i]+"' --start-time "+str(startTime)+" --stop-time "+str(endTime)+" vlc://quit",shell=True)
        
'''
