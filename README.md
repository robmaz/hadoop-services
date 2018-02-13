# Hadoop-services

Hadoop does not integrate well with service managers like launchd and systemd, rather relying on its own convoluted shell scripts and unsupervised ssh connections to start up things. Here I collect /experimental/ service files for MacOS/launchd and CentOS7/systemd.  Currently there are no releases or installer scripts, just subfolders for the two architectures. WARNING: The launchd script keep the services running, but have startup issues. Caveat emptor!
