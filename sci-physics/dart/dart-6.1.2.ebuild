# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="Dynamic Animation and Robotics Toolkit"
HOMEPAGE="http://dartsim.github.io/"
SRC_URI="https://github.com/dartsim/dart/archive/v${PV}.zip -> ${P}.zip"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="bullet doc flann examples gui ipopt nlopt ipopt simd openmp openmp tests tutorials utils"

CMAKE_MAKEFILE_GENERATOR=ninja
CMAKE_BUILD_TYPE=Release

RDEPEND="
	>=dev-util/cmake-2.8.12
	dev-util/ninja
	doc? ( app-doc/doxygen )
"
DEPEND="
	>=dev-libs/boost-1.46.0:=
	>=sci-libs/fcl-0.2.9:=
	>=sci-libs/libccd-1.4.0:=
	>=dev-cpp/eigen-3.0.5:=
	>=sci-libs/fcl-0.2.9:=
	>=media-libs/assimp-3.0.0:=
	bullet? ( sci-physics/bullet:=[bullet3] )
	flann? ( sci-libs/flann:= )
	openmp? ( sys-devel/gcc:=[openmp] )
	ipopt? ( >=sci-libs/ipopt-3.11.9:= )
	nlopt? ( >=sci-libs/nlopt-2.4.1:= )
	utils? (
		dev-libs/tinyxml:=
		dev-libs/tinyxml2:=
		dev-libs/urdfdom:= )
	gui? (
		>=dev-games/openscenegraph-3.0.0:=
		virtual/opengl:=
		media-libs/freeglut:= )
	${RDEPEND}
"

#PATCHES=

#DOCS=( AUTHORS.txt LICENSE.txt README.md )

# Building / linking of third Party library BussIK does not work out of the box
#RESTRICT="test"

#S="${WORKDIR}/${PN}3-${PV}"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DDART_ENABLE_SIMD=$(usex simd)
		-DDART_VERBOSE=ON
		-DENABLE_OPENMP=$(usex openmp)
		-DDART_BUILD_GUI_OSG=$(usex gui)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	use tests && cmake-utils_src_make tests
	use examples && cmake-utils_src_make examples
	use tutorials && cmake-utils_src_make tutorials
	use doc && cmake-utils_src_make docs
#	if use doc;
#		doxygen || die
#		HTML_DOCS+=( html/. )
#		DOCS+=( docs/*.pdf )
#	fi

}

src_install() {
	cmake-utils_src_install

#	if use examples; then
#		dodoc -r examples
#		docompress -x /usr/share/doc/${PF}/examples
#	fi
}
