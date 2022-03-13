#!/bin/sh

for i in *.wav;
  do name=`echo "$i" | cut -d'.' -f1`
  echo "$name"
  ffmpeg -i "$i" -codec:a libvorbis -qscale:a 8 "${name}.ogg"
done