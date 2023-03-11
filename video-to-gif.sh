#!/bin/bash

main() {
	if (( $# < 3 )); then
		>&2 echo "usage: $0 <infile> <seconds> <outfile> [size] [fps]"
		exit 1
	fi

	local infile="$1"
	local seconds="$2"
	local outfile="$3"
	local size="${4:-128}"
	local fps="${5:-30}"

	# TODO: this probably breaks if seconds is 10 or greater.

	local cmd=(ffmpeg -i "${infile}" -to "00:00:0${seconds}" -filter_complex "[0:v]fps=30,chromakey=ffffff:0.05,scale=${size}:-1,split[a][b];[a]palettegen[p];[b][p]paletteuse[out]" -map "[out]" "${outfile}")
	>&2 echo "ffmpeg command: ${cmd[@]}"
	"${cmd[@]}"
}

main "$@"
