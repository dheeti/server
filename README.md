### description
This repo contains some shell scripts and puppet code to get our server environment built

### run
You must have already created a DigitalOcean droplet and have root access

Test that you can actually connect to Droplet
```
ssh root@<host>
exit
```

Run configure script
```
scripts/configure.sh <host> admin
```
