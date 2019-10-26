#Creacion de certificados para que el firmware permita la virtualizacion
vmware_user="XXXXX"
vmware_path="/home/$vmware_user/vmware/"
cd $vmware_path

openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=VMware/"
sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 ./MOK.priv ./MOK.der $(modinfo -n vmmon)
sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 ./MOK.priv ./MOK.der $(modinfo -n vmnet)
sudo mokutil --import MOK.der
sudo shutdown -r now
 
