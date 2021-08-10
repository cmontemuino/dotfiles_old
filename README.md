# Dotfiles

These are **mine personalized dotfiles I use primarily in macOS**. Everything that is not under `macos` folder should work for Linux too..

## HowTo

**Please bear in mind that there is lot of stuff here. If you want to give it a try, I seriously recommend to [fork this repository](https://github.com/cmontemuino/dotfiles/fork), review the code, and remove things that does not make sense or are useless for you.**

### SSH Keys

The first thing you need to do is to generate new SSH keys and add them to your GitHub account. Alternatively, you could restore your a backup of your SSH keys to ~/.ssh.

**Avoid going further without completing this step.**

### You must install Git first

Don't you have `git` in your system? Then wait no more and install it. In my case (remember: I'm using macOS), I install it with the help of Homebrew:

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install
brew install git
```

### Installation

There are two possible installations paths:

1. Run the `bootstrap.sh` script and install everything (**last reminder: I'm using macOS. This operation will try to install macOS specific applications!!!**)
2. Alternatively, run the `setup.sh` script located in specific subfolders (e.g., `docker`) to setup something specific
