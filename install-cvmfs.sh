#!/bin/sh
#
# Utility for setting up and checking CernVM-FS on a Pawsey machine.
#----------------------------------------------------------------

EXE=$(basename "$0" .sh)
EXE_EXT=$(basename "$0")

PROXY=cvmfs-proxy.pawsey.org.au
PROXY2=cvmfs-proxy-2.pawsey.org.au
PROXY3=cvmfs-proxy-3.pawsey.org.au

#----------------------------------------------------------------
# Functions

root_required() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "$EXE: root privileges required (please run with \"sudo\")" >&2
    exit 1
  fi
}

uninstall_all() {
  apt-get -y autoremove cvmfs
  apt-get -y purge cvmfs
  rm -rf /etc/cvmfs
}

install_all() {
  ./cvmfs-client-setup.sh \
       --stratum-1 stratum1-cvmfs.pawsey.org.au \
       --proxy $PROXY3 \
       pubkeys/containers.cvmfs.pawsey.org.au.pub
       
  ./cvmfs-client-setup.sh \
       --stratum-1 bcws.test.aarnet.edu.au \
       --proxy $PROXY \
       --proxy $PROXY2 \
       pubkeys/containers.biocommons.aarnet.edu.au.pub \
       pubkeys/data.biocommons.aarnet.edu.au.pub \
       pubkeys/tools.biocommons.aarnet.edu.au.pub

  ./cvmfs-client-setup.sh \
       --proxy $PROXY \
       --proxy $PROXY2 \
       --stratum-1 cvmfs1-mel0.gvl.org.au \
       --stratum-1 cvmfs1-ufr0.galaxyproject.eu \
       --stratum-1 cvmfs1-tacc0.galaxyproject.org \
       --stratum-1 cvmfs1-iu0.galaxyproject.org \
       --stratum-1 cvmfs1-psu0.galaxyproject.org \
       --proxy cvmfs-cachingproxy.pawsey.org.au \
       pubkeys/cvmfs-config.galaxyproject.org.pub \
       pubkeys/data.galaxyproject.org.pub \
       pubkeys/main.galaxyproject.org.pub \
       pubkeys/sandbox.galaxyproject.org.pub \
       pubkeys/singularity.galaxyproject.org.pub \
       pubkeys/test.galaxyproject.org.pub \
       pubkeys/usegalaxy.galaxyproject.org.pub
}

chksetup() {
  cvmfs_config chksetup
}

status() {
  cvmfs_config status
}

mount_all() {
  
    ls /cvmfs/containers.biocommons.aarnet.edu.au
    ls /cvmfs/data.biocommons.aarnet.edu.au
    ls /cvmfs/tools.bioommons.aarnet.edu.au

    ls /cvmfs/cvmfs-config.galaxyproject.org
    ls /cvmfs/data.galaxyproject.org.pub
    ls /cvmfs/main.galaxyproject.org.pub
    ls /cvmfs/sandbox.galaxyproject.org.pub
    ls /cvmfs/singularity.galaxyproject.org.pub
    ls /cvmfs/test.galaxyproject.org.pub
    ls /cvmfs/usegalaxy.galaxyproject.org.pub
}

#----------------------------------------------------------------

DO_HELP=

if [ $# -eq 0 ]; then
  echo "$EXE: usage error: missing command" >&2
  DO_HELP=yes

elif [ $# -eq 1 ]; then
  case "$1" in
    uninstall)
      root_required
      uninstall_all ;;
    install)
      root_required
      install_all ;;
    chksetup)
      root_required
      chksetup ;;
    status)
      root_required
      status ;;
    mount)
      root_required
      mount_all ;;
    -h|--help|help)
      DO_HELP=yes
      ;;
    *)
      echo "$EXE: usage error: unknown command: $1 (-h for help)"
      exit 2
      ;;
  esac
else
  echo "$EXE: usage error: too many arguments (-h for help)" >&2
  exit 2
fi

if [ -n "$DO_HELP" ]; then
  cat <<EOF
Usage: $EXE_EXT command
Commands:
  uninstall  remove CernVM-FS and its configurations
  install    install CernVM-FS and the configurations
  chksetup   runs "cvmfs_config chksetup"
  status     runs "cvmfs_config status"
  mount      try to mount all the repositories
EOF
  exit 0
fi

#EOF
