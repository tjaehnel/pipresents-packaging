Installation of pipresents-rsync
================================

# What you need #
*   the pipresents-rsync debian package
*   useraccount on rsync capable ssh server with certificate login enabled
*   keypair for SSH login (see below)


# Operations to install and configure the package #
*   Upload the debian package to the Raspberry Pi and install it as root
        # dpkg -i pipresenrs-rsync_<version>.deb
*   The command might fail with a list of unresolved dependencies. If so, execute the following command and then try installation again.
        # apt-get -f install
*   Configure remote server access in /etc/default/pipresents
*   Generate keypair (if necessary) and put files into the correct directories (see below)
*   Make sure you are able to login to the remote SSH server without password
        # ssh -l <remote username> <ssh server>
    Perform this as user pi, NOT as root(!!).
After restarting your Raspberry Pi it gets the presentation from the rsync server and runs it. It also check for updates if your show every minute.

# Creating a keypair for passwordless SSH login #
*   Make sure that your remote server allows vertificate based
    logins for your desired user
*   Create a keypair
        # ssh-keygen -t rsa -b 2048
 *   Put the keypair (id_rsa and id_rsa.pub) into /home/pi/.ssh
     on your target Raspberry Pi
     If you run ssh-keygen as user pi it is put there automatically
 *   Do NOT assign a passphrase to your private key when ssh-keygen
     asks you to do so
*   Transfer the id_rsa.pub (this is your public key) to the
    SSH server and append it to the .ssh/authorized_keys file
    in the home directory of your remote user
        # cat id_rsa.pub | ssh -l <remote username> <ssh server> "cat >> ~/.ssh/authorized_keys"
*   You should now be able to login to your remote server without password
        # ssh -l <remote username> <ssh server>

