#!/usr/bin/env sh

################################################################################
# Description	: Work and edit whatever you want of our setup directly on your
#		  pc. You have to supply a path in which you want to work on the
#		  website and/or a path in which you want to work on the 
#		  presentation. The website is plain html+css+js and the presen-
#		  tation is LateX beamer. Have fun.
################################################################################

SCRIPT_NAME=${0}

error() { printf "%s\\n" "$1" 1>&2; exit 1; }
usage() 
{
	cat <<HERETO

Usage: $SCRIPT_NAME -w <web-folder> -t <presentation-folder>

Simple as that.

HERETO
}

webcp()
{
	printf "Copying web folder to %s...\\n" "$1"
	cp -r ./docs/* "$1" || return 1
}

texcp()
{
	printf "Copying presentation folder to %s...\\n" "$1"
	cp -r ./presentation/* "$1" || return 1
}

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

[ -n "$WEB" ] && { webcp "$WEB" || error "Error copying web files"; }
[ -n "$TEX" ] && { texcp "$TEX" || error "Error copying tex files"; }
