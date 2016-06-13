#!/bin/bash 

scriptdir=$(cd $(dirname ${0}); pwd)
tempdir="/tmp"
virtualenv="$scriptdir/venv"
version="2.8.12.1"

# Check for dependencies (Gtk, OpenGL libraries)
do_check() {
DEPS=$(echo {build-essential,libgtk2.0-dev,freeglut3,freeglut3-dev})
for i in $DEPS ; do
    dpkg-query -W -f='${Package}\n' | grep ^$i$ > /dev/null
    if [ $? != 0 ] ; then
        echo "Installing package $i ..."
        sudo apt-get install $i -y > /dev/null
    fi
done  
}

do_download() {
	echo "-> Download wxPython $version..."
	if ( wget -N https://sourceforge.net/projects/wxpython/files/wxPython/$version/wxPython-src-$version.tar.bz2 && \
		tar xjf wxPython-src-$version.tar.bz2
	)
	then
		echo "-> Download complete"
	else
		echo "-> Download failed!"
		return 1
	fi
}

do_extract() {
	echo "-> Extract wxPython $version archive..."
	if (tar xjf wxPython-src-$version.tar.bz2)
	then
		echo "-> Extract complete"
	else
		echo "-> Extract failed!"
		return 1
	fi
}

do_patch() {
	echo "-> Apply patch files..."
	# fix: configure: error: OpenGL libraries not available
	local pathfile="wxPython.configure.patch"
	if (cp -f $scriptdir/$pathfile wxPython-src-$version && \
		cd wxPython-src-$version && \
		patch configure < $pathfile
	)
	then
		echo "-> Patches applied"
	else
		echo "-> Failure patch installation!"
		return 1
	fi
}

do_build() {
	echo "-> Build wxPython $version..."

	# Fix: cc1plus: some warnings being treated as errors
	export CFLAGS="-Wno-error=declaration-after-statement"

	# setup virtalenv
	. $virtualenv/bin/activate

	if ( cd wxPython-src-$version && \
		./configure --prefix=$virtualenv --with-gtk=2 --with-opengl --enable-unicode && \
		make && \
		make install && \
		cd contrib && \
		make && \
		make install && \
		cd ../wxPython && \
		python setup.py install
	)
	then
		echo "-> Build complete"
	else
		echo "-> Build failed!"
		return 1
	fi
}

# main
do_check && \
cd $tempdir && \
do_download && do_patch && do_build