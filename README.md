### description
This repo contains a Vagrantfile which can be used to build our
server environment. You must have
[Vagrant](https://docs.vagrantup.com/v2/installation/index.html) and [VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads) installed.
Once installed you can use `vagrant` to either build a local environment or to deploy to a DigitalOcean droplet.

### local
Build a local environment
```
# download ubuntu/trusty64 box
vagrant box add ubuntu/trusty64 https://vagrantcloud.com/ubuntu/boxes/trusty64/versions/14.04/providers/virtualbox.box

# clone repo
git clone https://github.com/psu-capstone/server.git
cd server

# build environment
vagrant up
```
After a few minutes depending on connection speed to download all the required files, you should now be able to ```vagrant ssh``` onto the virtual machine.

### server
To deploy the environment onto DigitalOcean you will need to create an API Token and a SSH key and set proper environment variables.
+ [Follow steps to Generate Token](https://www.digitalocean.com/community/tutorials/how-to-use-the-digitalocean-api-v2)
+ [If needed create an SSH key](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2)

```
# install DigitalOcean plugin and download Box
vagrant plugin install vagrant-digitalocean
vagrant box add digital_ocean https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box

# clone repo
git clone https://github.com/psu-capstone/server.git
cd server
````
Create shell script that sets environment variables.
```vim vagrant_server.sh``` and add the following lines...
```
#!/bin/bash
export VAGRANT_MODE="<dev|prod>" # dev or prod currently does the same thing
export DO_SSH_KEY="</path/to/ssh/key>" # example path: ~/.ssh/id_rsa
export DO_API_TOKEN="<DigitalOcean API token>"
export DO_SERVER_NAME="<name of server>"

# create Droplet
vagrant up --provider=digital_ocean
```
Make script executable and and run it
```
chmod +x vagrant_server.sh
./vagrant_server.sh
```
If everything works it should deploy the environment to a Droplet. If you scroll back up past the puppet
output you should see the IP address it was assigned. You can use that address and connect as root user.









