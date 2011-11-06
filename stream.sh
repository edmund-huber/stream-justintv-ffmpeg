#!/bin/bash

INRES="1280x800"
OUTRES="1280x800"
FPS="20"
STREAM_KEY="$1"

ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0 \
 -f alsa -ac 2 -i pulse -vcodec libx264 -s "$OUTRES" \
 -acodec libmp3lame -ar 44100 -threads 0  \
 -f flv "rtmp://live.justin.tv/app/$STREAM_KEY"
