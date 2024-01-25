# manual installing
you need to first clone systemdjctl utility(```git clone https://underlevel.ddns.net/git/underlevel/systemdjctl```) and build it(```dub build --build=release```), after this move it to any dir in $PATH and then run
systemdjctl enable premount
systemdjctl enable remount
systemdjctl enable aftermount
systemdjctl enable hwdrivers
systemdjctl enable hostname
systemdjctl enable udev
systemdjctl enable sysctl
systemdjctl enable dbus
systemdjctl enable networkmanager
systemdjctl enable bluetooth // change path of bluetoothd in script
systemdjctl enable efivarfs

# Automated installer
run ```./installer.sh``` for automatic install. You need sudo or doas for this.