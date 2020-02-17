#!/bin/bash
#
# Set up hadoop services specified on the command line
#

services="hadoop-namenode hadoop-journalnode hadoop-secondarynamenode hadoop-datanode"
services="$services yarn-resourcemanager yarn-nodemanager yarn-timelineserver"

# usage notice
usage="Usage: $0 [<services>]

  Install systemd service files for various Hadoop-related <services>, namely,
  one or more of

    $(echo $services | sed -E 's/ /_    /g' | tr '_' '\n')

  Without argument, service files for all services are installed.
  Set JAVA_HOME, HADOOP_PREFIX, and HADOOP_CONF_DIR to indicate the
  local configuration.
"

# sed script to replace configuration items
sscript="
s@__java_home__@${JAVA_HOME:-/etc/alternatives/java_sdk_1.8.0}@g
s@__hadoop_prefix__@${HADOOP_PREFIX:-/opt/hadoop-current}@g
s@__hadoop_conf_dir__@${HADOOP_CONF_DIR:-/etc/hadoop/conf}@g
"

# install replacing __xxx__ patterns in service files
function hs_install()
{
  mod=${1}
  src=${2}.template
  if [[ -d "$3" ]]; then
    tgt="$3/$2"
  else
    tgt=$3
  fi
  rm -f "$tgt" && sed -e "$sscript" $src > $tgt
  chmod $mod $tgt
}

### execution starts here ###

if [[ -z "$@" ]]; then
  set -- $services
else
  args="$@"
  set --
  for a in $args; do
    case $a in
      (-h | --help | --usage | -?)
        echo "$usage" && exit
        ;;
      (*)
        if [[ "$services" =~ "$a" ]]; then
          set -- "$@" $a
        else
          echo "Unknown service $a, exiting."
          exit 1;
        fi
        ;;
    esac
  done
fi

# find folder for unit files
srvdir=$(pkg-config systemd --variable=systemdsystemunitdir)
echo -n "Installing $@ into $srvdir ... "

# install service files
mkdir -p "$srvdir"
for _s in $@; do
  srv="${_s}.service"
  hs_install 600 "$srv" "$srvdir/"
done

echo -n "done, reloading systemd ... "

systemctl daemon-reload

echo "done."

# for _s in "$@"; do
#   systemctl enable ${_s}.service && systemctl start ${_s}.service
# done
