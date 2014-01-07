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

restore-package:
	dpkg-source -x source-package/pipresents-${PIPVERSION}.dsc ${PIPSRCDIR}

build-source-package:
	cd ${PIPSRCDIR} && debuild -us -uc -S
	mkdir source-package
	mv pipresents_* source-package
	cp source-package/pipresents_${PIPVERSION}.orig.tar.gz .

build-binary-package:
	dpkg-source -x source-package/pipresents-${PIPVERSION}.dsc tmp
	cd tmp && debuild -us -uc -b 
	mkdir binary-package
	mv pipresents_* binary-package
	cp binary-package/pipresents_${PIPVERSION}.orig.tar.gz .
	rm -rf tmp

clean:
	-rm pipresents_*
	-rm -r ${PIPSRCDIR}
	-rm -r binary-package
	-rm -rf tmp	
