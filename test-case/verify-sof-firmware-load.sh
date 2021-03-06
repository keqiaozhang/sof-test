#!/bin/bash

##
## Case Name: verify-sof-firmware-load
## Description:
##    Check if the SOF fw load success in dmesg
## Case step:
##    Check demsg to search fw load info
## Expect result:
##    Get fw version info in demsg
##    sof-audio-pci 0000:00:0e.0: Firmware info: version 1:1:0-e5fe2
##    sof-audio-pci 0000:00:0e.0: Firmware: ABI 3:11:0 Kernel ABI 3:11:0
##

# source from the relative path of current folder
source $(dirname ${BASH_SOURCE[0]})/../case-lib/lib.sh

func_opt_parse_option $*

dlogi "Checking SOF Firmware load info in kernel log"
if [[ $(sof-kernel-dump.sh | grep "] sof-audio.*version") ]]; then
    # dump the version info and ABI info
    sof-kernel-dump.sh | grep "Firmware info" -A1
    # dump the debug info
    sof-kernel-dump.sh | grep "Firmware debug build" -A3
    exit 0
else
    dloge "Cannot find the sof audio version" && exit 1
fi
