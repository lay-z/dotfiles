#!/bin/zsh

echo "preview $1"
thing=$(echo "$1" | awk '{print $NF}')
echo "thing: $thing"
1=$thing
if [ -f "$1" ]; 
then 
  # Now we have to start doing some splits based on file types
  # Get the file mime type
  mime_type=$(file --mime-type -b "$1")
  case "$mime_type" in
    text/*)
      bat --color=always --theme auto "$1" ;;
    image/*)
      chafa -s ${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES} $1;;
    application/pdf)
      filename=$(basename $(echo "$1" | tr ' ' '_'))
      tmp_file="/tmp/${filename}-1.png"
      if [[ ! -f "$tmp_file" ]]; then
          pdftoppm -f 1 -l 1 -png "$1" "/tmp/$filename"
      fi
      chafa -s ${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES} $tmp_file;;
    application/zip|application/x-tar|application/x-gzip)
      unzip -l "$1" | bat ;;
    *)
      echo "Unsupported file type: $mime_type" 
      bat --theme auto --color=always "$1";;
  esac
elif [ -d "$1" ];
then 
  echo "is directory"
  eza -la --color=always --icons=always "$1" 
  # ll "$1"
fi
