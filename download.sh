#!/bin/bash
#Author: Chaoju Wang
#Version: 1.1
#Date:2018-06-08      Mail: cjwang1220@gmail.com
#Description: A downloder for the digital video recording of NAU Commencement

dir=$(pwd)
# TODO: Change the prefix of the TS URL, amount of the ts file, and the subtitles URL to fit your case.
amount=396
url=https://stream.ec.nau.edu/vod/amlst:4004/media_w1659020169_b3178000_
subtitles=https://player.extended.nau.edu/4004.vtt
filename="2018 Spring Commencement Friday 4 PM.ts"
subtitlesname="2018 Spring Commencement Friday 4 PM.vtt"

download(){
    echo "Downloading Subtitles"
    wget $subtitles -O $subtitlesname
    for x in {0..$amount}
    do
       echo "Downloading $x.ts"
       wget ${url}${x}.ts -O $x.ts
    done
}

check(){
    checkflag=1
    for x in {0..$amount}
    do
        if [ ! -f "${dir}/${x}.ts" ]; then
            echo "File $x.ts doesn't exist"
            checkflag=0
        fi
    done
    if [ $checkflag -eq 1 ]
    then
        echo "Check passed!"
    else
        echo "Check failed!"
    fi
}

merge(){
    if [ -f "${dir}/${filename}" ]; then
        rm -f $filename
        echo "$filename is deleted"
    fi
    for x in {0..$amount}
    do
        if [ ! -f "$x.ts" ]; then
            echo "$x.ts doesn't exist"
            break
        fi
    cat $x.ts >> $filename
    echo "$x.ts merged"
    done
    echo "Final Vedio: $filename"
}

echo "====Start Downloading===="
download
echo "====Download Completed===="
echo "====Checking the completion===="
check
echo "====Checking Completed===="
echo "====Start Merging===="
merge
echo "====Merging Completed"
