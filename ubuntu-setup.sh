#!/bin/bash

# Steps 1, 2, 3, and 5 from http://ubuntuforums.org/showthread.php?t=786095 .

# Clean up existing install of ffmpeg/x264, and get the packages that
# we'll need for building x264.
apt-get remove ffmpeg x264 libx264-dev
apt-get update
apt-get install build-essential checkinstall git libfaac-dev libjack-jackd2-dev \
  libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libsdl1.2-dev libtheora-dev \
  libva-dev libvdpau-dev libvorbis-dev libx11-dev libxfixes-dev texi2html yasm zlib1g-dev

# Clone the x264 project, build, and install
cd
git clone git://git.videolan.org/x264
cd x264
./configure --enable-static
make
checkinstall --pkgname=x264 --pkgversion="3:$(./version.sh | \
    awk -F'[" ]' '/POINT/{print $4"+git"$5}')" --backup=no --deldoc=yes \
    --fstrans=no --default

# Clone the ffmpeg project, build, and install
cd
git clone --depth 1 git://git.videolan.org/ffmpeg
cd ffmpeg
./configure --enable-gpl --enable-libfaac --enable-libmp3lame --enable-libopencore-amrnb \
    --enable-libopencore-amrwb --enable-libtheora --enable-libvorbis --enable-libx264 \
    --enable-nonfree --enable-postproc --enable-version3 --enable-x11grab
make
checkinstall --pkgname=ffmpeg --pkgversion="5:$(date +%Y%m%d%H%M)-git" --backup=no \
  --deldoc=yes --fstrans=no --default
hash x264 ffmpeg ffplay ffprobe