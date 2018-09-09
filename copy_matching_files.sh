#!/bin/bash
# Author: Corey Manning

## For each file with extension e in directory d, if directory contains file with same name and extension f, copy both files to new directory o
verbose='false'
input_dir=''
ext1=''
ext2=''
out_dir=''
current_dir=`pwd`

usage() {
	echo "Usage: $0 [-hv] [-d input_dir] [-e ext1] [-f ext2] [-o out_dir]"
	echo "	-v 	verbose mode"
	echo "	-h 	display help (this message)"
	echo "	-d 	inputdir	specify the directory on which to run the script"
	echo "	-e 	ext1		specify the extension of the first filetype to match"
	echo "	-f 	ext2		specify the extension of the second filetype to match"
	echo "	-o 	out_dir		specify the directory where the files should be copied to"
	exit 1;
}

while getopts 'd:e:f:o:vh' flag; do
	case "${flag}" in
		d) input_dir=${OPTARG} ;;
		e) ext1=${OPTARG} ;;
		f) ext2=${OPTARG} ;;
		o) out_dir=${OPTARG} ;;
		v) verbose='true' ;;
		h) usage ;;
		*) usage ;;
	esac
done

# -z means if the string is null or empty
if [ -z "${input_dir}" ] || [ -z "${ext1}" ] || [ -z "${ext2}" ] || [ -z "${out_dir}" ]; then
	usage
fi

#if input & output directories are not absolute paths, work from within the current directory
if [[ ! "$input_dir" = /* ]]; then
	input_dir=${current_dir}/${input_dir}
fi
if [[ ! "$out_dir" = /* ]]; then
	out_dir=${current_dir}/${out_dir}
fi

if [ "$verbose" = true ]; then
	echo "Current Directory: 				${current_dir}"
	echo "Input Directory: 					${input_dir}"
	echo "Output Directory: 				${out_dir}"
	echo "Extension 1: ${ext1}"
	echo "Extension 2: ${ext2}"
fi

if [ ! -d ${input_dir} ]; then
	echo "${input_dir} does not exist, exiting."
	exit 1
fi

if [ ! -d ${out_dir} ]; then
	if [ "$verbose" = true ]; then
		echo "${out_dir} does not exist, creating it."
	fi
	mkdir ${out_dir};
fi

### Change to the root directory where the expected files are
if [ "$verbose" = true ]; then
	echo "Moving to directory ${input_dir}"
fi
cd ${input_dir};

### Loop over all the files with extension ext1
if [ "$verbose" = true ]; then
	echo "Checking all files with extension ${ext1}"
fi

for file in $( find . -type f -iname "*.${ext1}" | cut -f 2- -d '/' ); do
	f1=$file;
	filename=$(echo "$f1" | cut -f 1 -d '.')

	## if there exists a matching file with the same name as f1 but with extension ext2, 
	## copy them both to the destination directory
	if [ -e "${filename}.${ext2}" ]; then
		f1=${filename}.${ext1}
		f2=${filename}.${ext2}

		if [ "$verbose" = true ]; then
			echo "Matching files:"
			echo "${f1}"
			echo "${f2}"
			echo ""
		fi

		cp ${f1} ${out_dir} 
		cp ${f2} ${out_dir}
	fi
done 
