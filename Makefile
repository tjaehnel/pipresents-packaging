TARBALLURL=https://github.com/KenT2/pipresents/tarball/master
PIPVERSION=1.1.2b

PIPSRCTARBALL=pipresents_${PIPVERSION}.orig.tar.gz
PIPSRCDIR=pipresents-${PIPVERSION}

download:
	# download pipresents
	wget ${TARBALLURL} -O - | tar xz
	# repackage
	mkdir ${PIPSRCDIR}
	mv KenT2-pipresents-* ${PIPSRCDIR}/pipresents
	tar -czf ${PIPSRCTARBALL} ${PIPSRCDIR}
	rm -rf ${PIPSRCDIR}

prepare-package:
	tar xzf ${PIPSRCTARBALL}
	cp -rp debian ${PIPSRCDIR}
	@echo
	@echo "-------- Now make changes to ${PIPSRCDIR} if necessary -----------"

build-source-package:
	cd ${PIPSRCDIR} && debuild -us -uc -S
	mkdir source-package
	mv pipresents_* source-package
