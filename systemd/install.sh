#!/bin/bash
#
# Set up hadoop services specified on the command line
#

# usage notice
usage="Usage: $0 <services>

  Install, enable and start systemd service files for various
  Hadoop-related <services>, namely, one or more of

         hadoop-namenode
         hadoop-journalnode
         hadoop-secondarynamenode
         hadoop-datanode
         yarn-resourcemanager
         yarn-nodemanager
         yarn-timelineserver

  HADOOP_PREFIX and HADOOP_CONF_DIR need to point to your Hadoop installation."

# sed script to replace configuration items
sscript="
s@__hadoop_prefix__@$HADOOP_PREFIX@g
s@__hadoop_conf_dir__@$HADOOP_CONF_DIR@g
"


# install replacing __xxx__ patterns in service files
function hs_install()
{
  mod=${1}
  src=${2}.template
  if [[ -d "$3" ]]; then
    tgt=$3/$2
  else
    tgt=$3
  fi
  sed -e "$sscript" $src > $tgt
  chmod $mod $tgt
}

### execution starts here ###

if [[ -z "$@" || -z "$HADOOP_CONF_DIR" || -z "$HADOOP_PREFIX" ]]; then
  echo "$usage"
  exit 1
fi

srvdir=$(pkg-config systemd --variable=systemdsystemunitdir)
mkdir -p $srvdir

for _s in "$@"; do
  srv=${_s}.service
  hs_install 600 $srv $srvdir/
done

systemctl daemon-reload

for _s in "$@"; do
  systemctl enable ${_s}.service && systemctl start ${_s}.service
done
