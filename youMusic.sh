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
		echo -e "\tmp3 file. Bit-rate Mp3 file is set on 192kb/s. Script use advantage ";
		echo -e "\tmulti-core processors and it divide convert to many available cores."
		echo -e "\tFor right working you must have below written library in your system."
		echo "";
		echo -e "\tDEPENDECIES:";
		echo -e "\t\t youtube-dl ffmpeg";
		echo -e "\t\t parallel"
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
		cat $1 | grep -v '^\s*$' | parallel xargs -L 1 -d '\n' youMusic_parser.sh;

		count_errors=$(cat Music/log.txt | grep -o "ERROR" | wc -l);

		echo "-----------------------------------------------------------------------"
		if [ $count_errors == 0 ]
		then
			echo "Success download all music :)";
		else
			echo "Download not complete :( for detail about errors see Music/log.txt";
		fi
		echo "-----------------------------------------------------------------------"

		# SERIAL VERSION for case when not available framework parallel for your system
		#cd Music
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
