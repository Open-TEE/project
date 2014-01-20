Open TEE project
=======

This repository contains the overall configuration for the Open TEE project and the associated documentation.

Community
------

Mailing list:
* open-tee[AT]googlegroups{DOT}com

IRC Channel
* #opentee on irc.freenode.net

Quick setup guide
------

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

Checkout version v1.01
    
    $ cd qbs
    $ git checkout v1.0.1
    $ qmake -r
    $ make -j4

Do not run make install if you don't have installation prefix defined, otherwise it will just create mess to your root directory. (This is marked as a bug to be resolved for next release of qbs.) !!

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

