### description
This repo contains some shell scripts and puppet code to get our server environment built.
As we learn more what needs to be on the server we can add puppet modules to handle that setup.

### run
Note: You must have already created a DigitalOcean droplet and have root access

```
# test that you can actually connect to Droplet
ssh root@<host>
exit

# run configure script
scripts/configure.sh <host> admin
```
