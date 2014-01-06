TARBALLURL=https://github.com/KenT2/pipresents/tarball/master
PIPVERSION=1.1.2b

PIPSRCDIR=pipresents-${PIPVERSION}

download:
	# download pipresents
	wget ${TARBALLURL} -O - | tar xz
	# repackage
	mv KenT2-pipresents-* ${PIPSRCDIR}
	tar -cf pipresents_${PIPVERSION}.orig.tar.gz ${PIPSRCDIR}

prepare-package:
	cp -rp debian ${PIPSRCDIR}

build-source-package:
	cd ${PIPSRCDIR}
	debuild -us -uc -S

