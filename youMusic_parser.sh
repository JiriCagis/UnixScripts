#!/bin/bash
 
line=$1;
album=$(echo ${line} | cut -d ';' -f 1);
song=$(echo ${line} | cut -d ';' -f 2);
url=$(echo ${line} | cut -d ';' -f 3);
youtube-dl --output "Music/${album}/${song}.%(ext)s" --playlist-items 1 --extract-audio --audio-format mp3 --audio-quality 168k --prefer-ffmpeg ${url} 2>&1 | tee -a Music/log.txt;
