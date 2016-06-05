#!/bin/sh
set -e -u

pypyhome=/usr/lib/pypy-upstream
bytecompile=1

usage() {
	name=$(basename $0)
	echo <<EOF
Usage: $name [--remove]"
Options:
  --remove  Only remove existing byte-compiled modules

EOF
}

while [ $# -ge 1 ]; do
	case "$1" in
	--remove)
		bytecompile=0
		;;
	-h|--help)
		usage
		exit 0
		;;
	*)
		echo "Unkown option: $1" >&2
		usage
		exit 1
		;;
	esac
	shift
done

if [ $bytecompile -gt 0 ]; then
	echo "Byte-compiling PyPy standard library (this might take a while)..."
else
	echo "Removing byte-compiled PyPy standard library..."
fi

find $pypyhome/lib-python $pypyhome/lib_pypy -name '*.pyc' -delete
find $pypyhome -type d -empty -delete

if [ $bytecompile -gt 0 ]; then
	# We know that some files are going to fail to byte-compile:
	# (e.g. bits of test suites that are intentionally invalid)
	find $pypyhome/lib-python $pypyhome/lib_pypy -name '*.py' | pypy -m py_compile - > /dev/null 2>/dev/null || true
fi
