# Environment

This [vagrant](https://www.vagrantup.com/) environment configures a basic [Gogs](https://gogs.io/) installation with a local [SQLite3](https://www.sqlite.org/index.html) database.

# Requirements

1. Vagrant
2. Virtualbox
3. A computer with Virtualization (VTx) enabled in BIOS

# Usage

Deploy a new CentOS 7 VM in Virtualbox and 'gogs' docker container by running:
    vagrant up

Sign In into Gogs using the `administrator` username and `gogs` password at:

> http://localhost:3000/user/login

Add your [public SSH key](https://git-scm.com/book/en/v2/Git-on-the-Server-Generating-Your-SSH-Public-Key) into Gogs, for that open your Gogs profile SSH keys page at:

> http://localhost:3000/user/settings/ssh

Add a new SSH key with your SSH public key, for that, just copy the contents of
your `id_rsa.pub` file. Get its contents with, e.g.:

```sh
cat ~/.ssh/id_rsa.pub
```

Create a new repository named `hello` at:

> http://localhost:3000/repo/create

You can now clone that repository with SSH or HTTPS:

```sh
git clone git@git.example.com:gogs/hello.git
GIT_SSL_NO_VERIFY=true git clone http://gogs@localhost:3000/gogs/hello.git
```

**NB** This vagrant environment does not have a proper SSL certificate, as such,
HTTPS cloning will fail with `SSL certificate problem: self signed certificate`.
To temporarily ignore that error we set the [`GIT_SSL_NO_VERIFY=true` environment
variable](https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables).

Make some changes to the cloned repository and push them:

```sh
cd hello
echo '# Hello World' >> README.md
git add README.md
git commit -m 'some change'
GIT_SSL_NO_VERIFY=true git push
```
