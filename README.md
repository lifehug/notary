# Notary

Automate the signing of software from a build server, script, runner or manual process requiring multiple signatures. GPG can be difficult to configure on different machines and often behaves differently in each environemnt. Keeping GPG on multiple machines in sync for an automated build system can be difficult. 

Notary demonstrates how to use the keys from each system to build a container that will sign with each machines credentials respectivly. Only minimal provisioning of a host is required to set up automated signing and a container can be used multiple times during it's instance.

## Provision host with GPG credentials

Create your keys as you normally would following the [Generating Keys](https://www.gnupg.org/gph/en/manual/c14.html) documentation
```
gpg --gen-key
```

Export your key(s) from your build system to a location of your choosing

```
--export-secret-keys > private.keys
```

## Building your container

Build your container, with your secret password, which can also be supplied via an environment variable. 

```
docker build --build-arg private_key=private.keys --build-arg passphrase="secret_password" -t notary .
```

Don't forget to remove your key export after your container is built

```
srm private.keys
```

## Sigining your software

Run your container while suppplying it with the name of the file to be signed and mount point of your software into the notary workspace

```
 docker run  -v $PWD:/notary -e file=test.txt notary
````



