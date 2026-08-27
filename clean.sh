#!/bin/bash
#Script to make distclean from the buildroot directory
#Referenced script by:  Tim Bailey, tiba6275@colorado.edu

if [ -d "buildroot" ]
then
	cd buildroot
	echo "running distclean"
	make distclean
else
    echo "buildroot directory does not exist."
	exit 1
fi