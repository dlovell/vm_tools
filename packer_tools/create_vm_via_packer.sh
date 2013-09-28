# create vmware config
packer_config_filename=vmware_packer_config.json
cat -- >$packer_config_filename <<EOF
{
	"builders": [{
	"type": "vmware",
	"iso_url": "http://old-releases.ubuntu.com/releases/precise/ubuntu-12.04.2-server-amd64.iso",
	"iso_checksum": "af5f788aee1b32c4b2634734309cc9e9",
	"iso_checksum_type": "md5",
	"ssh_username": "packer",
	"ssh_password": "packer",
	"shutdown_command": "echo packer | sudo -S shutdown -P now",
	"disk_size": 8000,
	"boot_command": [ "<esc><esc><enter><wait>", "/install/vmlinuz noapic ", "preseed/url=http://gist.github.com/dlovell/6574899/raw/c95ea6bcbcc1e56cbba6f53296a516a5d3b4cbb1/ubuntu-12.04.2-server-preseed.cfg ", "debian-installer=en_US auto locale=en_US kbd-chooser/method=us ", "hostname={{ .Name }} ", "fb=false debconf/frontend=noninteractive ", "keyboard-configuration/modelcode=SKIP keyboard-configuration/layout=USA ", "keyboard-configuration/variant=USA console-setup/ask_detect=false ", "initrd=/install/initrd.gz -- <enter>" ]
}]
}
EOF

# validate and build
packer validate $packer_config_filename && packer build $packer_config_filename
