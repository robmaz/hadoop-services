# Hadoop-services

Hadoop does not integrate well with service managers like launchd and systemd, rather relying on its own convoluted shell scripts and unsupervised ssh connections to start up things. Here I collect *experimental* service files for MacOS/launchd and CentOS7/systemd.  The systemd/ subfolders also has a setup script to install services. The launchd scripts rely on a delay to avoid trying to bind their address before the network interface is up. This is not ideal, but I don't think launchd supports a better way.
