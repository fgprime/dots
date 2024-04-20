if ! test -e /Volumes/RamDiskCache ; then
    echo "Creating RamDiskCache volume."
    /usr/sbin/diskutil erasevolume HFS+ "RamDiskCache" `/usr/bin/hdiutil attach -nobrowse -nomount ram://8388608`
    chmod 755 /Volumes/RamDiskCache
    #mount specific folder into ramdisk
    #diskutil mount -mountPoint node_modules /dev/disk1s2
else
    echo "RamDiskCache already exists."
fi



