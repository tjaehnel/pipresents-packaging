TARBALLURL=https://github.com/KenT2/pipresents/tarball/master
PIPVERSION=1.1.2b
PACKAGEREVISION=1

PIPSRCTARBALL=pipresents_${PIPVERSION}.orig.tar.gz
PIPSRCDIR=pipresents-rsync-${PIPVERSION}

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
	dpkg-source -x source-package/pipresents_${PIPVERSION}.dsc ${PIPSRCDIR}

source-package:
	cd ${PIPSRCDIR} && debuild -us -uc -S
	-rm -r source-package
	mkdir source-package
	mv pipresents_* source-package
	cp source-package/${PIPSRCTARBALL} .

# build binary package from source package
binary-package:
	dpkg-source -x source-package/pipresents-rsync_${PIPVERSION}-${PACKAGEREVISION}.dsc tmp
	cd tmp && debuild -us -uc -b 
	-rm -r binary-package
	mkdir binary-package
	mv pipresents_* binary-package
	cp binary-package/${PIPSRCTARBALL} .
	rm -rf tmp

clean:
	-rm pipresents_*
	-rm -r ${PIPSRCDIR}
	-rm -r binary-package
	-rm -rf tmp

