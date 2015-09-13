# Dropbox Supervisor Docker Container #

The shell version of [Dropbox](https://www.dropbox.com/) managed inside a container by [Supervisord](http://supervisord.org/).

The Dropbox client runs as an unprivileged user inside the container, the `$HOME` volume of the container can be static mounted inside the host if desired, the container will manage to assign the permissions of the unprivileged user at its first boot.

To link the container to a *Dropbox account* visit the http server interface of **Supervisor** exposed at port `8000` and click the `tail -f` button of the `Dropbox` service to learn the `URL` to be used.

## Why to use this image ##
Apart from containing the `dropbox` daemon under low privileges, you can easily run multiple containers having multiple Dropbox accounts and by using these as [data volume container](https://docs.docker.com/userguide/dockervolumes/#creating-and-mounting-a-data-volume-container) easily access the multiple accounts at once.

## Usage ##
* `--volumes-from` to mount the `$HOME` in other container.
* `-net="host"` to enable the [lansync](https://www.dropbox.com/help/137) functionality of **Dropbox**.
* assign the port `8000` to the host so as to access the web interface of **Supervisor**
