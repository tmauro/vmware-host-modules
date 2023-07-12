
vmware_user="mtorres"
vmware_path="/home/$vmware_user/VM/vmware/"
vmware_version=$(vmware --version|awk '{print $3}')
# kernel_version=$(uname -r|awk -F"." '{print $1"."$2}')
host_module="vmware-host-modules-w"$vmware_version
zip_module="w"$vmware_version".zip"
url="https://github.com/mkubecek/vmware-host-modules/archive/refs/tags"

echo URL:$url/$zip_module

cd $vmware_path
rm -rf $host_module

if [ ! -s "$zip_module" ]; then
    wget $url/$zip_module
    chmod 777  $zip_module
    chown $vmware_user:$vmware_user $zip_module
fi

unzip $zip_module

cd $host_module
make
make install

cd $vmware_path
#/usr/src/kernels/$(uname -r)/scripts/sign-file sha256 ./MOK.priv ./MOK.der $(modinfo -n vmmon)
#/usr/src/kernels/$(uname -r)/scripts/sign-file sha256 ./MOK.priv ./MOK.der $(modinfo -n vmnet)

rm -rf $host_module

systemctl restart vmware

#$wget https://github.com/mkubecek/vmware-host-modules/archive/workstation-17.0.0.tar.gz
# sudo rm -rf vmware-host-modules-workstation-17.0.0
# tar -xzf workstation-17.0.0.tar.gz
# cd vmware-host-modules-workstation-17.0.0
# make
# sudo make install
# sudo systemctl restart vmware
# exit 0
#=============================================================