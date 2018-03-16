# Hadoop-services

Hadoop does not integrate well with service managers like launchd and systemd, rather relying on its own convoluted shell scripts and unsupervised ssh connections to start up things. Here I collect *experimental* service files for MacOS/launchd and CentOS7/systemd.  Currently there are no releases or working installer scripts, just subfolders for the two architectures. WARNING: The launchd script keeps the service running, but has startup issues. The problem is
probably that the datanode binds the address before the
network interface is up. Caveat emptor!
