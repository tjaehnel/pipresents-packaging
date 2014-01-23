PI PRESENTS PACKAGING
=====================

For instructions how to install and configure the debian package, see INSTALL.md

This project is used to create a debian package (.deb) for the pipresents software (https://github.com/KenT2/pipresents). This debian package can be installed on a Raspberry Pi.

It includes a init script and creates an example configuration file located in /etc/default/pipresents

Checkout this project
    git clone https://github.com/tjaehnel/pipresents-packaging

To create the current version of the binary package from the checked in source package run:
        make extract-source-package
        make binary-package

To make a new package release with changed package-related files but without upgrading the pipresents sources.
*   extract current version of the sources
        make extract-source-package
*   Increment revision in the Makefile
*   Create new changelog entry in debian/changelog file
*   Build the new source package
        make source-package
*   Release the new version of the source package
        git commit -a
        git push
*   Build binary package
        make binary-package

If you want to release a new version of the package based on the latest pipresents sources:
*   Change version and revision in the Makefile
    (set revision to 1 for the first package release of the new pipresents version)
*   Create a new changelog entry in debian/changelog file
*   Build a source package from the newest sources from the internet
        make download
        make prepare-package
        make source-package
*   Release the new version of the source package
        git commit -a
        git push
*   Build the binary package
        make binary-package

