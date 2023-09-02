# macos-setup

A collection of scripts for provisioning a new macOS environment with all my necessary tools and files.

## Usage

Run `setup.sh`.

## Modifications

A list of all the changes made.

### Fonts

* Installs the [JetBrains Mono](https://www.jetbrains.com/lp/mono/) font.

### PyEnv

### NVM

### Homebrew Package Manager

* Contains my `Brewfile` for installing all packages and utilities for [Homebrew Package Manager](https://brew.sh/) (`brew`).

### SSH

* Added functionality for automatically loading the user's SSH key (`~/.ssh/id_rsa`).
* Added functionality for loading the SSH agent if one has already been launched by another terminal instance.

### Application Preferences

Includes `.plist` configuration files for various applications.

#### Fork

* Adds scripts for opening repositories in JetBrains WebStorm, Rider, and PyCharm.

#### iTerm2

* Configuration profile for iTerm2.
* Adjusted background opacity.
* Adjusted font.
* Adjusted key mappings for a more "natural" typing feeling.
