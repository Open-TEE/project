Open TEE project
=======

This repository contains the overall configuration for the Open TEE project and the associated documentation.

Overview
------

The goal of the Open-TEE open source project is to implement a "virtual TEE" compliant with the recent <a href="http://globalplatform.org/specificationsdevice.asp"> Global Platform TEE specifications </a>.

Our primary motivation for the virtual TEE is to use it as a tool for developers of Trusted Applications and researchers interested in using TEEs or building new protocols and systems on top of it. Although hardware-based TEEs are ubiquitous in smartphones and tablets ordinary developers and researchers do not have access to it. While the emerging Global Platform specifications may change this situation in the future, a fully functional virtual TEE can help developers and researchers right away.

We intend Trusted Applications developed using our virtual TEE can be compiled and run for any target that complies with the specifications.

The Open-TEE project is being led by the <a href="http://se-sy.org">Secure Systems group</a> as part of our activities at the <a href="http://www.icri-sc.org/"> Intel Collaborative Research Institute for Secure Computing </a>


All activities of the project are
public and all results are in the public domain. We welcome anyone interested to join us in contributing to the project.

Community
------

Mailing list:
* open-tee[AT]googlegroups{DOT}com

IRC Channel
* #opentee on irc.freenode.net

Quick setup guide
------

### Dependant libraries and tools

apt-get install uuid-dev libssl-dev libglu1-mesa-dev libelfg0-dev mesa-common-dev build-essential git curl

### Cloning the repositories

We decided to use the Android repo tool to conveniently manage the numerous repositories.  What follows is a brief introduction to getting started using this tool, however, full documentation is available at http://source.android.com/source/using-repo.html

Get the repo launcher:

    $ curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    $ chmod +x ~/bin/repo

Create a directory where you want to checkout the repositories:

    $ mkdir open-tee

Install repo in the directory and have it fetch the manifest for the Open-TEE project:

    $ cd open-tee
    # for normal users who only want to follow and build the code you can do the following

    $ ~/bin/repo init -u https://github.com/Open-TEE/manifest.git

    # for those wishing to contribute back to the project
    # signup on http://gerrithub.io/
    # follow the steps there to get a working copy of Open-Tee (uses github as the backend)
    # then initialize the project repo

    $ ~/bin/repo init -u https://github.com/Open-TEE/manifest.git -m developer.xml

    # then you can add the following to your ~/.ssh/config
    host review.gerrithub.io
        port 29418
        user <github username>

Lastly, have repo fetch the repositories defined in the manifest:

    $ ~/bin/repo sync

Once cloned, you can work on the repositories in a normal git fashion!

    #for the developers you can push for gerrit review using the following command
    $ git push origin HEAD:refs/for/master


### QBS

Initially we have decided to use the qbs build system (http://doc-snapshot.qt-project.org/qbs/) for easy configuration, though we may move to a more mainstream solution such as Autotools when time permits.

    $ git clone git://gitorious.org/qt-labs/qbs.git

or

    $ git clone https://git.gitorious.org/qt-labs/qbs.git

Build without installing:

    $ cd qbs
    $ qmake -r
    $ make -j4

If you wish to run qbs from a location other than the build directory (optional), run:

    $ make install INSTALL_ROOT=$HOME/<PATH TO QBS>

**Note:** Do not run make install if you don't have installation prefix defined, otherwise it will just create mess to your root directory. (This is marked as a bug to be resolved for next release of qbs.) !!

You may want to include `~/qbs/bin` (or similar) to your `PATH` environment variable.

For a permanent solution do:
edit `~/.profile`

    if [ -d "$HOME/<PATH TO QBS>/bin" ] ; then
        PATH="$HOME/<PATH TO QBS>/bin:$PATH"
    fi

for this one session do:

    $ export PATH="$HOME/<PATH TO QBS>/bin:$PATH"

Now configure qbs:

    $ qbs detect-toolchains
    $ qbs config --list profiles

For qbs 1.3.2:

    $ qbs qbs setup-toolchains --detect
    $ qbs config --list profiles

Optionally you may select one of the profiles to be the default one e.g. to set the gcc profile as default

    $ qbs config defaultProfile gcc


### Building the project

    $ cd open-tee/

If you have a profile called gcc listed from the above command then the following will be used to build with that profile

    $ qbs profile:gcc debug

If a default is set then simply call

    $ qbs debug

The result of the compilation will be found under `<profile>-debug` e.g.

    $ cd gcc-debug

### Installing the config files

    # Edit opentee.conf to point the library path to your runtime path then
    $ sudo cp opentee.conf /etc/opentee.conf

<a href="https://scan.coverity.com/projects/3441">
  <img alt="Coverity Scan Build Status"
       src="https://scan.coverity.com/projects/3441/badge.svg"/>
</a>
