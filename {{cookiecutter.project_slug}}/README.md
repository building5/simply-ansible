# {{ cookiecutter.project_name }}

{{ cookiecutter.description }}

## Build requirements

### General

 * [Python 2.7](https://www.python.org/)
   * Installed by default on OS X
 * [Virtualenv][]
   * `pip install virtualenv`
 * [Virtualbox][]
   * For development on local VMs
 * [Vagrant][]
   * For building those local VMs
 * Vagrant plugins
   * [vagrant-reload](https://github.com/aidanns/vagrant-reload)
     * `vagrant plugin install vagrant-reload`

## Basic usage

There are a set of `.sh` scripts in the root directory, which wrap calls to
`ansible-playbook`, so that we are calling it consistently. Each script has a
`--help` option for more details.

Each script also honors a `--` option, for passing options directly to
`ansible-playbook`. This allows you to pass additional options for running the
playbook.

    $ ./deploy.sh -- --limit mariadb

## Vagrant

A `Vagrantfile` is provided to spin up local development VMs. When spinning up a
new environment, be sure to run deploy with `--initial` once, so the new VMs can
be properly deployed to.

    # Spin up VMs
    $ vagrant up

    # Initial deploy; only need to do once
    $ ./deploy.sh --env vagrant --initial

    # Full deploy
    $ ./deploy.sh --env vagrant

## Deploy

    $ ./deploy.sh --env vagrant

### `-- [ansible-options]`

    $ ./deploy.sh -- --limit services --check

As mentioned above, to pass arbitrary option to the `ansible-playbook` call, you
can set them after the `--` option. This is especially useful for passing along
`--tags`, `--limit` or `--check`.

### `--really-reboot`

    $ ./deploy.sh --really-reboot

The Ansible scripts detect when a reboot may be necessary to apply updates.
Since rebooting in the middle of a deploy would violate the principle of least
surprise, it will only happen when the `--really-reboot` option is present.

### `--initial`

    $ ./deploy --initial -- --limit something-new

Normally, deploys use your username (or whatever is configured in
`~/.ssh/config`) for managing target machines. But when an instance is first
created, the only the `ubuntu` user is preconfigured. Passing the `--initial`
option sets up the playbook run accordingly.

The `--initial` option also implies `--really-reboot`, since rebooting on intial
deployment is usually a really good idea. If there are only a few hosts which
you'd like to initialize, use the `--limit` ansible option to ensure you do not
reboot anything unexpectedly.

## Development

The infrastructure scripts must be idempotent. It should be safe to simple run
`./deploy.sh` at any time, without any ill effects or unexpected behavior.

The automation scripts are primarily [Ansible][] scripts. A [Virtualenv][] is
used to ensure that the proper version of Ansible and its dependencies are used.
The contents of the virtualenv are in `requirements.txt`. The `activate.sh`
manages the virtualenv, and activates it for the shell.

Not many [Ansible Galaxy][] dependencies are used, but they are listed in
`requirements.yml`.

Please see [Simply Ansible][] for Ansible best practices for writing new
roles/playbooks.

# License

{{ cookiecutter.license }}

 [ansible galaxy]: https://galaxy.ansible.com/
 [ansible]: https://www.ansible.com/
 [simply ansible]: https://github.com/building5/simply-ansible/tree/master/docs
 [vagrant]: https://www.vagrantup.com
 [virtualbox]: https://www.virtualbox.org/
 [virtualenv]: https://virtualenv.pypa.io/en/stable/
