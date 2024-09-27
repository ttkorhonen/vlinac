#!/bin/sh

# Where are we?
cd `dirname "$0"`
TOP=`/bin/pwd`

# What are we running on?
case `uname -sp` in
    "Linux i386" | "Linux i486" | "Linux i586" | "Linux i686")
        ARCH=linux-x86
        export LD_LIBRARY_PATH="$TOP/lib/$ARCH"
        ;;
    "Linux x86_64")
        ARCH=linux-x86_64
        export LD_LIBRARY_PATH="$TOP/lib/$ARCH"
        ;;
    "Darwin powerpc" | "Darwin i386" | "Darwin arm" )
        echo "Use startIoc.command on Darwin (MacOS)"
        exit 1
        ;;
    *)
        echo "Virtual Linac doesn't support this architecture : `uname -sp`"
        exit 1
        ;;
esac
BIN="$TOP/bin/$ARCH"

# Disable external network activity
EPICS_CA_AUTO_ADDR_LIST=NO
EPICS_CA_ADDR_LIST=localhost
export EPICS_CA_AUTO_ADDR_LIST
export EPICS_CA_ADDR_LIST

# Start a CA Repeater, quietly
$BIN/caRepeater 2>&1 >/dev/null &

# Run vlinac IOC
exec $BIN/vlinac st.cmd
