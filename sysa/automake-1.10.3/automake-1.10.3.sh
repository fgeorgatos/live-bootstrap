# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    default_src_prepare

    ./bootstrap
}

src_configure() {
    ./configure CC=tcc --prefix=/after
}

src_compile() {
    make MAKEINFO=true CC=tcc
}

src_install() {
    make install MAKEINFO=true DESTDIR="${DESTDIR}"
}
