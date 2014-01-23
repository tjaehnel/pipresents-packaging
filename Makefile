TARBALLURL=https://github.com/KenT2/pipresents/tarball/master
PACKAGENAME=pipresents-rsync
PIPVERSION=1.1.2b
PACKAGEREVISION=1

PIPSRCTARBALL=${PACKAGENAME}_${PIPVERSION}.orig.tar.gz
PIPSRCDIR=${PACKAGENAME}-${PIPVERSION}

.PHONY: download prepare-package extract-source-package source-package binary-package clean
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
	-rm -r ${PIPSRCDIR}/debian
	cp -rp debian ${PIPSRCDIR}
	@echo
	@echo "-------- Now make changes to ${PIPSRCDIR} if necessary -----------"

extract-source-package:
	dpkg-source -x source-package/${PACKAGENAME}_${PIPVERSION}-${PACKAGEREVISION}.dsc ${PIPSRCDIR}

source-package:
	cd ${PIPSRCDIR} && debuild -us -uc -S
	-rm -r source-package
	mkdir source-package
	mv ${PACKAGENAME}_* source-package
	cp source-package/${PIPSRCTARBALL} .

# build binary package from source package
binary-package:
	dpkg-source -x source-package/${PACKAGENAME}_${PIPVERSION}-${PACKAGEREVISION}.dsc tmp
	cd tmp && debuild -us -uc -b 
	-rm -r binary-package
	mkdir binary-package
	mv ${PACKAGENAME}_* binary-package
	cp binary-package/${PIPSRCTARBALL} .
	rm -rf tmp

clean:
	-rm ${PACKAGENAME}_*
	-rm -r ${PIPSRCDIR}
	-rm -r binary-package
	-rm -rf tmp

