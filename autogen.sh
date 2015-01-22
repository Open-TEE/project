 #!/bin/sh -e

basedir=$(dirname $0)

pushd "$basedir" > /dev/null
mkdir -p "./{,emulator,libtee,tests,CAs,TAs}/m4"
autoreconf --install --symlink
popd > /dev/null

"$basedir"/configure --prefix="/usr" $@
