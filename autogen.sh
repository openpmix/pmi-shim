:

srcdir=$(dirname "$0")
if test "x$srcdir" != x; then
   # in case we ever autogen on a platform without dirname
  cd $srcdir
fi

cd config
autom4te --language=m4sh pmishim_get_version.m4sh -o pmishim_get_version.sh
cd ..

autoreconf ${autoreconf_args:-"-ivf"}
