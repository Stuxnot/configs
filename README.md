# Description
My setup supports two machines. A desktop with two and a laptop with one
monitor. 
Which configuration is loaded depends on the environment variables `MONITOR` 
and `SIDE_MONITOR` set by `.profile`

## Installation
```shell
git clone --bare https://github.com/stuxnot/configs.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
```
I followed [this](https://www.atlassian.com/git/tutorials/dotfiles) tutorial
after being made aware of it by [ton1ght](https://github.com/ton1ght).

##  Credit
Thanks to everyone credited in the files. Their projects and setups really helped
and inspired me. 

Special thanks to [ton1ght](https://github.com/ton1ght) who first got me into 
ricing and often helped me along the way.

Almost forgot: __I use Arch, btw.__
