 #!/bin/sh -e

basedir=$(dirname $0)

pushd "$basedir" > /dev/null
autoreconf --install --symlink
popd > /dev/null

"$basedir"/configure --prefix="/opt/OpenTee" $@
