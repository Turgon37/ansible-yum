#!/usr/bin/env bash

GRUB_CONFIG=/boot/grub/grub.conf
GRUB2_CONFIG=/boot/grub2/grub.cfg

status=0

if [ -f "$GRUB_CONFIG" ]; then
  awk '
BEGIN{ exit_code = 0; kernel_version = ""; kernel = ""; initrd = "" }
{
  if ($1 == "title") {
    if (kernel_version != "") {
      if (kernel == "") { print "=== Error === kernel version "kernel_version" miss kernel line."; exit_code = 1 };
      if (initrd == "") { print "=== Error === kernel version "kernel_version" miss initrd line."; exit_code = 1 }
    };

    kernel_version=$4;
    kernel="";
    initrd=""
  };

  if ($1 == "kernel") { kernel = $2 };
  if ($1 == "initrd") { initrd = $2 }
}
END{ exit exit_code }' "$GRUB_CONFIG" 1>&2
  if [ "$?" -ne 0 ]; then
    status=1
  fi
fi


if [ -f "$GRUB2_CONFIG" ]; then
  awk '
BEGIN{ exit_code = 0; kernel_version = ""; kernel = ""; initrd = "" }
{
  if ($1 == "menuentry") {
    if (kernel_version != "") {
      if (kernel == "") { print "=== Error === kernel version "kernel_version" miss kernel line."; exit_code = 1 };
      if (initrd == "") { print "=== Error === kernel version "kernel_version" miss initrd line."; exit_code = 1 }
    };

    kernel_version=$4;
    kernel="";
    initrd=""
  };

  if ($1 == "linux16") { kernel = $2 };
  if ($1 == "initrd16") { initrd = $2 }
}
END{ exit exit_code }' "$GRUB2_CONFIG" 1>&2
  if [ "$?" -ne 0 ]; then
    status=1
  fi
fi

if [ "$status" -ne 0 ]; then
  echo 'According to the errors above, you system may be unable to reboot correctly'
  echo 'You should considers re-install kernel package of affected version (with yum reinstall kernel-$(uname -r))'
  echo 'If the initrd is in cause, you can manually fix the problem with "dracut -f /boot/initramfs-$(uname -r).img $(uname -r)"'
fi
