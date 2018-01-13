#!/usr/bin/env bash

awk '
BEGIN{ kernel_version = ""; kernel = ""; initrd = "" }
{
  if ($1 == "title") {
    if (kernel_version != "") {
      if (kernel == "") { print "Error kernel version "kernel_version" miss kernel line." };
      if (initrd == "") { print "Error kernel version "kernel_version" miss initrd line." }
    };

    kernel_version=$4;
    kernel="";
    initrd=""
  };

  if ($1 == "kernel") { kernel = $2 };
  if ($1 == "initrd") { initrd = $2 }
}
END{}' /boot/grub/menu.lst 1>&2
