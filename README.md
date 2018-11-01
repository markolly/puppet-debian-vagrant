# puppet-debian-vagrant
Puppet module to provide initial configuration for Debian based Vagrant boxes running on Virtualbox

## Installation
```
git clone git@github.com:markolly/puppet-debian_vagrant.git
cd puppet-debian-vagrant.git
bundle
ln -s ../../scripts/pre-commit.sh .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

To bypass pre-commit git hook tests run commits with the --no-verify option or -n flag.

```
git commit -nm "Commit message"
```
