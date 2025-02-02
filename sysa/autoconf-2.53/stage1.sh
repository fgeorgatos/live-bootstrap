# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    default_src_prepare

    rm Makefile.in */Makefile.in */*/Makefile.in aclocal.m4 configure
    rm doc/standards.info doc/autoconf.info

    aclocal-1.6
    cat config/m4.m4 >> aclocal.m4
    autoconf-2.52
    automake-1.6

    # Not supported by autoconf-2.52
    sed -i "s#@abs_top_builddir@#$PWD#" tests/wrappl.in
    sed -i "s#@abs_top_srcdir@#$PWD#" tests/wrappl.in

    # Install autoconf data files into versioned directory
    for file in */*/Makefile.in */Makefile.in Makefile.in; do
        sed -i '/^pkgdatadir/s:$:-@VERSION@:' $file
    done
}

src_configure() {
    ./configure --prefix="${PREFIX}" --program-suffix=-2.53
}

src_compile() {
    make MAKEINFO=true DESTDIR="${DESTDIR}"
}

src_install() {
    make install MAKEINFO=true DESTDIR="${DESTDIR}"
}
