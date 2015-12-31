### description
This repo contains a Vagrantfile which can be used to build our
neo4j environment. You must have
[Vagrant](https://docs.vagrantup.com/v2/installation/index.html) and [VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads) installed.
Once installed you can use `vagrant` to either build a local environment or to deploy to a DigitalOcean droplet.

### project structure

+ `cql` - Contains Cypher cql files used to delete and build nodes for a sample graph along with some example queries
+ `data` - Contains two folders `nodes` and `links` which contain csv files used as test data to build a sample graph for the abortion issue
+ `puppet` - Contains puppet manifests and modules to setup Ubuntu box running a Neo4j instance
+ `python` - Python script to build relationships between nodes loaded with the `cql/node_loader.cql` using
  csv files in `data/links` 
+ `scripts` - Shell scripts to provision box with puppet and build sample graph

To rebuild entire sample graph
```
vagrant ssh
cd /vagrant/scripts
./build_sample_graph.sh
```

### local
Build a local environment
```
# download ubuntu/trusty64 box
vagrant box add ubuntu/trusty64 https://vagrantcloud.com/ubuntu/boxes/trusty64/versions/14.04/providers/virtualbox.box

# clone repo
git clone https://github.com/psu-capstone/neo4j.git
cd neo4j

# build environment
vagrant up
```
After a few minutes depending on connection speed to download all the required files,
you should now be able to ```vagrant ssh``` onto the virtual machine.

The neo4j instance is available at `127.0.0.1:7474`

### server
To deploy the environment onto DigitalOcean you will need to create an API Token and a
SSH key and set proper environment variables.
+ [Follow steps to Generate Token](https://www.digitalocean.com/community/tutorials/how-to-use-the-digitalocean-api-v2)
+ [If needed create an SSH key](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2)

```
# install DigitalOcean plugin and download Box
vagrant plugin install vagrant-digitalocean
vagrant box add digital_ocean https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box

# clone repo
git clone https://github.com/psu-capstone/neo4j.git
cd neo4j
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


