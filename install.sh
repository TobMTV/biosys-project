#!/usr/bin/env sh

################################################################################
# Description	: Dispacher for installation scripts
################################################################################

SCRIPT_NAME=$( readlink -f "$0" | xargs basename )

error() { printf "%s\\n" "$1" 1>&2; exit 1; }

usage()
{
  cat <<HERETO
Usage: $SCRIPT_NAME <[db|database]|[pc|computer]|[api|server]> [options] <args>

  db|database:	no arguments
  pc|computer:	-t <presentation-folder> -w <web-folder>
  api|server:	---work in progress---

HERETO
}

# Deploy our docker server on your own. It is meant to be a testing deployment. 
# Assuming you're on Ubuntu server 18.04 LTS.
install_db()
{
  # Testing the environment
  command -v docker > /dev/null || error "You need Docker to preceed."
  [ ! -d "./database" ] && error "The file should be in the repo root folder."
  cd "database" || error "Something went wrong, do you have access permission?"

  # Building Docker images
  sudo docker build 							\
    -t casalinovalerio/reverseproxy 					\
    ./reverseproxy							\
  || error "Error building reverseproxy image"

  sudo docker build 							\
    -t casalinovalerio/mybigchaindb	 				\
    ./mybigchaindb							\
  || error "Error building mybigchaindb image"

  # Deploy and return back to original folder
  sudo docker-compose up -d || error "Error with docker-compose"
  cd ..
}

# Work and edit whatever you want of our setup directly on your pc. You have to 
# supply a path in which you want to work on the website and/or a path in which 
# you want to work on the presentation. The website is plain html+css+js and 
# the presentation is LateX beamer. Have fun.
install_pc()
{
  while getopts "w:t:" opt; do
    case $opt in
      t)
        [ ! -d "$OPTARG" ] && error "$OPTARG not a directory"
        TEX="$OPTARG"
	;;
      w)
	[ ! -d "$OPTARG" ] && error "$OPTARG not a directory"
	WEB="$OPTARG"
	;;
      *)
	usage
	exit 0
	;;
    esac
done

[ -n "$WEB" ] && { 
  printf "Copying web folder to %s...\\n" "$WEB"
  cp -r ./website/* "$WEB" || error "Error copying web files"; }

[ -n "$TEX" ] && {
  printf "Copying presentation folder to %s...\\n" "$TEX"    
  cp -r ./presentation/* "$TEX" || error "Error copying tex files"; }

}

install_srv()
{
  if [ -n "$1" ]; then
    WEB_PATH="$1" 
  else 
    WEB_PATH="/var/www/html"
  fi

  [ ! -d "$WEB_PATH" ] && error "No web path found"
  cp -r ./api/* "$WEB_PATH" || error "Error copying files"
} 

[ "$#" -eq 0 ] && { usage; exit 0; }

case "$1" in
  db|database) 
    install_db
    ;;
  pc|computer)
    shift
    install_pc $@
    ;;
  api|server)
    shift
    install_srv $@
    exit 0
    ;;
  *)
    usage
    exit 0
    ;;
esac
