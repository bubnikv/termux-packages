# http(s) link to package home page.
TERMUX_PKG_HOMEPAGE=https://github.com/hutorny/usbuart

# One-line, short package description.
TERMUX_PKG_DESCRIPTION="A cross-platform library for reading/wring data via USB-UART adapters"

# License.
TERMUX_PKG_LICENSE="GPL-2.0"

# Version.
TERMUX_PKG_VERSION=1.0

# URL to archive with source code.
TERMUX_PKG_SRCURL=https://github.com/hutorny/usbuart/archive/b6797bcb9f3fff319f6b4991a9183f7f83a2c5cc.tar.gz

# SHA-256 checksum of the source code archive.
TERMUX_PKG_SHA256=6e20bec2193ffab8ee22a3be7612d71edb2edf3e40a1b85275024be738fc2983

TERMUX_PKG_DEPENDS=libusb

TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
        echo "CC: $CC"
        echo "CXX: $CXX"
        echo "LD: $LD"
	ls -l "$TERMUX_PREFIX/include/libusb-1.0"
	mkdir ./build
        PREFIX= make --trace "CC=$CC" "CXX=$CXX" "LD=$CXX" BUILD-DIR=./build "INCLUDES=include $TERMUX_PREFIX/include/libusb-1.0" "LDFLAGS=-shared -fPIC -L$TERMUX_PREFIX/lib -lusb-1.0"
	$CXX -Wall -Wextra -O3 -std=c++1y examples/uartcat.cpp -o bin/uartcat -I $TERMUX_PREFIX/include/libusb-1.0 -I include -L$TERMUX_PREFIX/lib -lusb-1.0 -L bin -lusbuart
}

termux_step_make_install() {
	cp bin/libusbuart.so $TERMUX_PREFIX/lib
	cp bin/uartcat $TERMUX_PREFIX/bin
	cp include/usbuart.h $TERMUX_PREFIX/include
	cp README.md $TERMUX_PREFIX/share/doc/libusbuart/
}

TERMUX_SUBPKG_DESCRIPTION="Utility to stream USB UART from/to console"
TERMUX_SUBPKG_INCLUDE="$TERMUX_PREFIX/bin/usbuartcat"
