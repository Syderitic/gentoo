# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg

DESCRIPTION="Nintendo DS emulator"
HOMEPAGE="http://desmume.org/"
SRC_URI="mirror://sourceforge/desmume/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="wifi glx openal hud glade"

RDEPEND="
	dev-libs/zziplib
	gnome-base/libglade
	media-libs/libsdl[joystick,opengl,video]
	sys-libs/zlib
	virtual/opengl
	x11-libs/agg
	>=x11-libs/gtk+-2.8.0:2
	x11-libs/gtkglext
	openal? ( media-libs/openal )
	glade? ( dev-util/glade )"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog README README.LIN )

# fix QA compiler warning, see
# https://sourceforge.net/p/desmume/patches/172/
PATCHES=(
	"${FILESDIR}/${P}-fix-pointer-conversion-warning.diff"
	"${FILESDIR}/${P}-gcc6.patch"
	"${FILESDIR}/${P}-gcc7.patch"
)

src_configure() {
	econf \
		$(use_enable wifi ) \
		$(use_enable glx ) \
		$(use_enable openal ) \
		$(use_enable glade ) \
		$(use_enable hud )
}
