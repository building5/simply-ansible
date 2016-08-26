# Simply Ansible

From what started out as a [slide deck][] describing getting started and best
practices for [Ansible][], [Simply Ansible][] is now a [cookiecutter][] template
for quickly getting started with a decent [Ansible][] project structure. It has
a handful of roles that I've found useful, and is a decent starting point for
new projects.

For no other reason than to serve as an example, these scripts spin up:
 * Node.js on [Ubuntu][] xenial (representing new services)
 * Ruby 2.3.1 on [Ubuntu][] trusty (representing legacy services)
 * Ruby 2.1.10 on [Ubuntu][] precise (representing something crazy old you
   really ought to replace)
 * A [CentOS][] 7 VM, because there's always something that has to be different

## Usage

```bash
$ pip install cookiecutter # or your favorite package manager

$ cookiecutter gh:building5/simply-ansible
```

Or if you happen to have a local clone of this repo:

```bash
$ cookiecutter ./simply-ansible
```

## Features

 * Running Ansible in a [virtualenv][], to avoid surprises from version
`   differences on different control machines
 * Wrapper scripts for consistently running `ansible-playbook`
 * [Vagrant][] for local development
 * Installs a role from [Ansible galaxy][]

## TODO

 * [AWS Cloudformation][] scripts for spinning up staging and production
   environments.
   * And inventory and associated `group_vars`
 * Test if `project_slug` is a valid domain name
 * Figure out how to avoid shared accounts. Ansible should SSH as the user
   running the playbook; not as a shared user like `vagrant` or `ubuntu`
   * But that shared user is necessary for initial spinups, since that's the
     only user on the VM.

## LICENSE

[ISC License][]

 [ansible galaxy]: https://galaxy.ansible.com/
 [ansible]: https://www.ansible.combativity/
 [aws cloudformation]: https://aws.amazon.com/cloudformation/
 [centos]: https://www.centos.org/
 [cookiecutter]: https://cookiecutter.readthedocs.io/en/latest/
 [isc license]: https://opensource.org/licenses/ISC
 [slide deck]: ./docs
 [ubuntu]: http://www.ubuntu.com/
 [vagrant]: https://www.vagrantup.com/
 [virtualenv]: https://virtualenv.pypa.io/en/stable/
 [simply ansible]: https://github.com/building5/simply-ansible
