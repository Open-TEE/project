Open-TEE project
=======

<a href="https://scan.coverity.com/projects/3441">
  <img alt="Coverity Scan Build Status"
       src="https://scan.coverity.com/projects/3441/badge.svg"/>
</a>

This repository contains the overall configuration for the Open-TEE project and the associated documentation.

- [Overview](#overview)
- [Community](#community)
- [Setup](#setup-guide)
    - [Prerequisites](#prerequisites)
    - [Obtaining the Source](#obtaining-the-source)
    - [Building using QBS](#building-using-qbs)
    - [Building using Autotools](#building-using-autotools)
    - [Configuration](#configuration)
    - [Running and Debugging](#running-and-debugging)
- [Options](#options)
    - [Command Line Option](#command-line-options)
    - [Environmental Variables](#environmental-variables)
- [FAQ](#faq)
- [Contact](#contact)
- [License](#license)

Overview
------

The goal of the Open-TEE open source project is to implement a "virtual TEE" compliant with the recent <a href="http://globalplatform.org/specificationsdevice.asp"> Global Platform TEE specifications </a>.

Our primary motivation for the virtual TEE is to use it as a tool for developers of Trusted Applications and researchers interested in using TEEs or building new protocols and systems on top of it. Although hardware-based TEEs are ubiquitous in smartphones and tablets ordinary developers and researchers do not have access to it. While the emerging Global Platform specifications may change this situation in the future, a fully functional virtual TEE can help developers and researchers right away.

We intend that Trusted Applications developed using our virtual TEE can be compiled and run for any target that complies with the specifications.

The Open-TEE project is being led by the <a href="http://se-sy.org">Secure Systems group</a> as part of our activities at the <a href="http://www.icri-sc.org/"> Intel Collaborative Research Institute for Secure Computing </a>

All activities of the project are public and all results are in the public domain. We welcome anyone interested to join us in contributing to the project.

Setup
------

This guide describes how to obtain and build Open-TEE from source on Ubuntu 14.04 LTS (Trusty Tahr). We currently support building Open-TEE using either the [QBS](https://wiki.qt.io/Qt_Build_Suite) build tool or [Autotools](https://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html).

If you simply wish to build Open-TEE using the suggested configuration, you can also follow the tutorial at:

http://open-tee.github.io/documentation/

If you wish to build Open-TEE for Android, consult the Android specific build documentation at:

http://open-tee.github.io/documentation/#android

### Prerequisites

Open-TEE uses the Android `repo` tool to manage the Git repositories that contain the source code. What follows are step-by-step instructions for setting up the build environment for Open-TEE.
Full documentation for `repo` is available at https://source.android.com/source/using-repo.html

You'll also need to install `git`, `curl`, `pkg-config` and the necessary build dependencies:

    $ sudo apt-get install git curl pkg-config build-essential uuid-dev libssl-dev libglu1-mesa-dev libelfg0-dev mesa-common-dev libfuse-dev

Introduce yourself to `git` if you haven't done so already:

    $ git config --global user.name "Firstname Lastname"
    $ git config --global user.email "name@example.com"

#### Installing Repo

Fetch the `repo` repository management tool:

    $ mkdir -p ~/bin
    $ curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    $ chmod +x ~/bin/repo

#### Installing QBS

Open-TEE requires `qbs` 1.4.2 or above. Up-to-date packages of `qbs` for Ubuntu 14.04 are available from the [qutIM PPA](https://launchpad.net/~qutim/+archive/ubuntu/qutim).

Issue the following commands to add the PPA and install `qbs`:

    $ sudo add-apt-repository ppa:qutim/qutim
    $ sudo apt-get update
    $ sudo apt-get install qbs

#### Installing Autotools

The Autotools build has been tested with [Autoconfig](https://www.gnu.org/software/autoconf/autoconf.html) 2.69 and above. To perform an Autotools build you need to install `autoconf`, `automake` and `libtool`:

    $ sudo apt-get install autoconf automake libtool

### Obtaining the Source

Create a directory where the repositories are to be cloned:

    $ mkdir Open-TEE
    $ cs Open-TEE

Have `repo` fetch the manifest for the Open-TEE project:

    $ ~/bin/repo init -u https://github.com/Open-TEE/manifest.git

Those wishing to contribute to Open-TEE need signup to the [GerritHub](http://gerrithub.io/) Code Review tool (requires a GitHub account) and initialize `repo` using the the developer configuration:

    $ ~/bin/repo init -u https://github.com/Open-TEE/manifest.git -m developer.xml

To submit changes to GerritHub you'll also need to add the following to your `~/.ssh/config`:

>  
> host review.gerrithub.io  
>       port 29418  
>       user <github-username-here>  
>  

Have `repo` fetch the repositories defined in the manifests:

    $ ~/bin/repo sync -j10

Once cloned, you can work on the repositories in a normal git fashion. Developers wishing to contribute can push changes ro Gerrit for review using the following command:

    $ git push origin HEAD:refs/for/master

### Building using QBS

Configure `qbs` for your toolchain:

    $ qbs detect-toolchains
    $ qbs config --list profiles

Optionally you may select one of the profiles to be the default one e.g. to set the `gcc` profile as default

    $ qbs config defaultProfile gcc

Finally, build Open-TEE:

    $ qbs debug

The result of the compilation will be found under `<profile>-debug`, e.g. executables and libraries under `gcc-debug` and trusted application objects under `gcc-debug/TAs`. 

### Building using Autotools

We recommend using a parallel build tree (a.k.a. `VPATH` build):

    $ mkdir build

The provided `autogen.sh` script will generate and run the `configure` script.

    $ cd build
    $ ../autogen.sh

To build and install Open-TEE run:

    $ make
    $ sudo make install

By default Open-TEE will be installed under `/opt/Open-TEE`. The directory will contain the following subdirectories:

* `/opt/Open-TEE/bin`       - executables

* `/opt/Open-TEE/include`   - public header files

* `/opt/Open-TEE/lib`       - shared library objects (_libdir_)

* ``/opt/Open-TEE/lib/TAs`` - trusted application objects (_tadir_)

### Configuration

Open the configuration file with your preferred editor:

    $ sudo $EDITOR /etc/opentee.conf

Add the sample configuration given below to the configuration file:

>  
> [PATHS]  
> ta\_dir\_path = _PATH_/_TO_/_TADIR_  
> core\_lib\_path = _PATH_/_TO_/_LIBDIR_  
> subprocess\_manager = libManagerApi.<span></span>so  
> subprocess\_launcher = libLauncherApi.<span></span>so  
>

For a `qbs` build you can use:

>  
> [PATHS]  
> ta\_dir\_path = _PATHNAME_/Open-TEE/gcc-debug/TAs  
> core\_lib\_path = _PATHNAME_/Open-TEE/gcc-debug  
> subprocess\_manager = libManagerApi.<span></span>so  
> subprocess\_launcher = libLauncherApi.<span></span>so  
>  

where _PATHNAME_ is replaced with the absolute path to the parent directory of the Open-TEE directory you created earlier. The pathname must **not** include special variables such as `~` or `$HOME`.

For an autotools build you can use

>  
> [PATHS]  
> ta\_dir\_path = /opt/Open-TEE/lib/TAs  
> core\_lib\_path = /opt/Open-TEE/lib  
> subprocess\_manager = libManagerApi.<span></span>so  
> subprocess\_launcher = libLauncherApi.<span></span>so  
>  

### Running and Debugging

You are now ready to launch the `opentee-engine`.

For a `qbs` build:

    $ cd gcc-debug
    $ ./opentee-engine

For an autotools build:

    $ /opt/Open-TEE/bin/opentee-engine

Verify that Open-TEE is running with `ps`:  

    $ ps waux | grep tee

You should see output similar to the example below:

>
> gcc-debug$ ps waux |grep tee  
> brian     5738  0.0  0.0  97176   852 ?        Sl   10:40   0:00 tee_manager  
> brian     5739  0.0  0.0  25216  1144 ?        S    10:40   0:00 tee_launcher  
>

Now launch and attach `gdb` to the `tee_launcher` process:

    $ gdb -ex "set follow-fork-mode child" opentee-engine $(pidof tee_launcher)

The `set follow-fork-mode child` command passed to `gdb` on the command line causes `gdb` to follow children processes across forks in order to drop into the TA process itself and resume execution.

In second terminal run the client application:

    $ cd Open-TEE/gcc-debug
    $ ./conn_test_app

or 

    $ /opt/Open-TEE/bin/conn_test_app

You should now expect to see output similar to the following:

>
> gcc-debug$ ./conn_test_app  
> START: conn test app  
> Initializing context: 
>

Back in `gdb` you can now step through and debug the trusted application the `conn_test_app` is connected to. If you continue execution you should see output from the `conn_test_app` similar to the following:

>
> gcc-debug$ ./conn_test_app  
> START: conn test app  
> Initializing context: initialized  
> Openning session: opened  
> yyyyyyyyyyyyyyyyyyyyxxxxx  
> Invoking command: invoked  
> Closing session: Closed  
> Finalizing ctx: Finalized  
> END: conn test app
>

Options
------

### Command Line Options

The `opentee-engine` executable supports the following command line options:

Usage: `./bin/opentee-engine [OPTION...]`

* `-p`, `--pid-dir=PATH`  
  Specify path to keep pid file.  
  Defaults to:
  - `/var/run/opentee` when run by root, or
  - `/tmp/opentee when` run by a non-root user.


* `-c`, `--config=FILE`  
  Specify path to configuration file.  
  Defaults to: `/etc/opentee.conf`


* `-f`, `--foreground`  
  Do not daemonize but start the process in foreground.


* `-h`, `--help`  
  Print list of command line options.

### Environmental Variables

The following environmental variables control the behaviour of Open-TEE:

* `OPENTEE_SOCKET_FILE_PATH`  
  Defines path to socket used for communication between `tee_manager` and `libtee`.  
  Defaults to `/tmp/open_tee_sock` on Linux  
  Defaults to `/data/local/tmp/open_tee_sock` on Android


* `OPENTEE_STORAGE_PATH`  
  Defines directory used for object storage.  
  Defaults to `$HOME/.TEE_secure_storage` on Linux  
  Defaults to `/data` on Android

FAQ
------

If you get the following error when trying to attach `gdb` to `tee_launcher`:

>  
> Could not attach to process.  If your uid matches the uid of the target  
> process, check the setting of /proc/sys/kernel/yama/ptrace_scope, or try  
> again as the root user.  For more details, see /etc/sysctl.d/10-ptrace.conf  
> ptrace: Operation not permitted.  
>  

Run the following command and invoke `gdb` again:

    $ echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope 

Contact
------

Mailing list:
* open-tee[AT]googlegroups{DOT}com

IRC channel:
* #opentee on irc.freenode.net

Bug reports and other issues:
* https://github.com/Open-TEE/project/issues

License
------

Open-TEE is licensed under the Apache License 2.0 (see LICENSE).

