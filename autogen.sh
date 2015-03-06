 #!/bin/sh -e

basedir=$(dirname $0)

pushd "$basedir" > /dev/null
mkdir -p ./{,emulator,libtee,libtee_pkcs11,tests,CAs,TAs}/m4
autoreconf --install --symlink
popd > /dev/null

"$basedir"/configure --prefix="/opt/OpenTee" $@
