#!/bin/bash
PROGRAM_NAME="youMusic"
VERSION="1.0"
DATE="21.8.2016"

case "$1" in 
	"--h") 
		#define styles
		bold=$(tput bold)
		normal=$(tput sgr0)
		
		echo "${bold}NAME${normal}";
		echo -e "\t${PROGRAM_NAME} - Script download entire music library from youtube"
		echo -e "\t           defined by CSV file."
		echo ""

		echo "${bold}DESCRIPTION${normal}"
		echo -e "\tThis script connect to Youtube server and download determinate video";
		echo -e "\tdefined by URL in CSV file. After downloaded, Script convert video to";
		echo -e "\tmp4 file. Bit-rate Mp4 file is set on 192kb/s. For right working ";
		echo -e "\tyou must install youtube-dl library. If you use debian distribution,"
		echo -e "\ttype to terminal: sudo apt-get install youtube-dl ffmpeg "
		echo ""; 
		echo -e "\tINPUT:";
		echo -e "\t\tCSV file formated by: album_name;song_name;url_to_song";
		echo "";
		echo -e "\tOUTPUT:"
		echo -e "\t\tScript create directory called Music with other"
		echo -e "\t\tdirectories defined by album name."

		echo "${bold}USAGES${normal}";

		echo -e "\t${bold}${PROGRAM_NAME}${normal} --h";
		echo -e "\t\t Display the manual page for this script.";
		echo "";

		echo -e "\t${bold}${PROGRAM_NAME}${normal} --v";
		echo -e "\t\t Show information about version this script.";
		echo "";

		echo -e "\t${bold}${PROGRAM_NAME}${normal} file.csv";
		echo -e "\t\t Download all music placed in file.csv from youtube.";
		echo "";

		echo "${bold}AUTHOR${normal}";
		echo -e "\tOriginally written by Jiri Caga <jiricaga30@gmail.com>."
	;;
	"--v") 
		echo "Version $VERSION written by Jiri Caga $DATE";
	;;
	*)
		mkdir Music
		#cd Music


		cat $1 | grep -v '^\s*$' | parallel xargs -L 1 -d '\n' you_music_parser.sh;


		#csv_file=$1;
		#lines=$(cat $1 | grep -v '^\s*$');
		#mkdir Music
		#cd Music
		
		#IFS=$'\n' 
		#for line in ${lines}
		#do
		#	album=$(echo ${line} | cut -d ';' -f 1);
		#	song=$(echo ${line} | cut -d ';' -f 2);
		#	url=$(echo ${line} | cut -d ';' -f 3);
			
		#	echo ${url}
			#youtube-dl --extract-audio --audio-format mp3 --prefer-ffmpeg "${url}"
		#	youtube-dl --output "${album}/${song}.%(ext)s" --playlist-items 1 --extract-audio --audio-format mp3 --prefer-ffmpeg ${url} | tee log.txt;
		#done
		
	;;
esac
