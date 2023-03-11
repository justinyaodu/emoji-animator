#!/bin/bash

main() {
	if (( $# != 3 )); then
		>&2 echo "usage: $0 <infile> <seconds> <outfile>"
		exit 1
	fi

	# TODO: this probably breaks if seconds is 10 or greater.

	ffmpeg -i "$1" -to "00:00:0${2}" -filter_complex "[0:v]fps=30,chromakey=ffffff:0.05,scale=128:128,split[a][b];[a]palettegen[p];[b][p]paletteuse[out]" -map "[out]" "$3"
}

main "$@"
