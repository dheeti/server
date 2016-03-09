Build and Deploy Democracy Lab project
======================================

You will need `vagrant` installed on your path.

Clone
```
git clone https://github.com/psu-capstone/server.git
cd server
```

# Deploy locally

```
cd db
vagrant up  # build vm with Neo4j instance and load test data
cd ../application
vagrant up  # build vm with churchill and dlab-api applications
```

If everything worked the Neo4j instance should be running at `localhost:7474`
+ default user: `neo4j`
+ default password: `neo`

The application should be accesible at `localhost:3000`

# Deploy to Digital Ocean

To deploy to Digital Ocean you will also need ...
+ Digital Ocean account
+ api token
+ ssh key added to account
+ [vagrant-digitalocean](https://github.com/smdahlen/vagrant-digitalocean) plugin installed

Set environment variables read by `Vagrantfile`
```
export VAGRANT_MODE="prod"
export DO_API_TOKEN="api token from DO"
export DO_SSH_KEY="path to ssh key uploaded to DO"
export DO_SERVER_NAME="db instance name"
```


Build and Deploy Neo4j database server
```
cd db
vagrant up --provider=digital_ocean
cd ..
```

Set environment variable pointing to Neo4j instance and application server name
```
export NEO4J_URI="http://neo4j:neo@<ip of created db server>/db/data"
export DO_SERVER_NAME="application instance name"
```

Build and Deploy application server
```
cd application
vagrant up --provider=digital_ocean
```

If everything worked you should be able to access the app at the ip address of the server
in a web browser.

