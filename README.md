# puppet-debian-vagrant
Puppet module to provide initial configuration for Debian based Vagrant boxes running on Virtualbox

## Installation
```
git clone git@github.com:markolly/puppet-debian_vagrant.git
cd puppet-debian_vagrant.git
bundle
ln -s ../../scripts/pre-commit.sh .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

To bypass pre-commit git hook tests run commits with the --no-verify option or -n flag. This is particularly useful when making changes to tests.

```
git commit -nm "Commit message"
```
