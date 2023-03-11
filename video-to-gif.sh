#!/bin/bash

main() {
	if (( $# < 3 )); then
		>&2 echo "usage: $0 <infile> <seconds> <outfile> [bgcolor] [similarity] [size] [fps]"
		exit 1
	fi

	local infile="$1"
	local seconds="$2"
	local outfile="$3"
	local bgcolor="${4:-ffffff}"
	local similarity="${5:-0.2}"
	local size="${6:-128}"
	local fps="${7:-30}"

	# TODO: this probably breaks if seconds is 10 or greater.

	local cmd=(ffmpeg -i "${infile}" -to "00:00:0${seconds}" -filter_complex "[0:v]fps=30,colorkey=${bgcolor}:${similarity},scale=${size}:-1,split[a][b];[a]palettegen[p];[b][p]paletteuse[out]" -map "[out]" "${outfile}")
	>&2 echo "ffmpeg command: ${cmd[@]}"
	"${cmd[@]}"
}

main "$@"
