PI PRESENTS PACKAGING
=====================

This project is used to create a debian package (.deb) for the pipresents software (https://github.com/KenT2/pipresents). This debian package can be installed on a Raspberry Pi.

It includes a init script and creates an example configuration file located in /etc/default/pipresents

Checkout this project
 git clone https://github.com/tjaehnel/pipresents-packaging

To create the current version of the binary package from the checked in source package run:
 make binary-package

If you want to release a new version of the package:
*   Change version in the Makefile
*   Build a source package from the newest sources from the internet
 make download
 make prepare-package
 make source-package
*   Release the new version of the source package
 git commit -a
 git push
*   Build the binary package
 make binary-package

