#!/bin/bash
# source: http://techsviewer.com/install-macos-sierra-virtualbox-windows/

echo "--- cpuidset ---"
VBoxManage modifyvm "macOS Sierra 10.12 Public Beta" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
VBoxManage setextradata "macOS Sierra 10.12 Public Beta" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"
echo "--- Setting Extra Data DmiSystemProduct ---"
VBoxManage setextradata "macOS Sierra 10.12 Public Beta" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
echo "--- Setting Extra Data DmiBoardProduct ---"
VBoxManage setextradata "macOS Sierra 10.12 Public Beta" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
echo "--- Setting Extra Data DeviceKey ---"
VBoxManage setextradata "macOS Sierra 10.12 Public Beta" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
echo "--- Setting Extra Data GetKeyFromRealSMC ---"
VBoxManage setextradata "macOS Sierra 10.12 Public Beta" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1
echo "--- DONE ---"
