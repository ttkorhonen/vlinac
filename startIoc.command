#!/bin/sh

# Where are we?
cd `dirname "$0"`
TOP=`/bin/pwd`

case `uname -sp` in
    "Darwin i386")
        ARCH=darwin-x86
        ;;
    "Darwin powerpc")
        ARCH=darwin-ppc
        ;;
    "Darwin arm")
        ARCH=darwin-aarch64
        ;;
    *)
        echo "This script is intended for Darwin (MacOS) only"
        exit 1
        ;;
esac

BIN="$TOP/bin/$ARCH"
export DYLD_LIBRARY_PATH="$TOP/lib/$ARCH"

# Disable external network activity
export EPICS_CA_AUTO_ADDR_LIST=NO
export EPICS_CA_ADDR_LIST=localhost

# Start a CA Repeater, quietly
$BIN/caRepeater 2>&1 >/dev/null &

# Run vlinac IOC
exec $BIN/vlinac st.cmd
