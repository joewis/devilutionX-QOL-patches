# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Sometimes build with ninja fails.
# Please check occasionally if we can revert back to ninja.
# Latest known issue:
#
#CMAKE_MAKEFILE_GENERATOR="emake"

inherit cmake desktop

DESCRIPTION="Diablo engine for modern operating systems with QOL patches"
HOMEPAGE="https://github.com/diasurgical/devilutionX https://github.com/spidertoast/devilutionX-QOL-patches"
if [[ "${PV}" == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/diasurgical/devilutionX.git"
else
	SRC_URI="
		https://github.com/diasurgical/devilutionX/archive/${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/spidertoast/devilutionX-QOL-patches/raw/master/devilutionX-QOL-patches-${PVR}.tar.gz
		"



	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/devilutionX-${PV}"
fi

LICENSE="public-domain"
SLOT="1"

IUSE="debug lto"

RDEPEND="
	dev-libs/libsodium
	media-libs/libsdl2[haptic]
	media-libs/sdl2-mixer
	media-libs/sdl2-ttf
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"
PATCHES=(
		"${WORKDIR}/patches/infernity_common_v02.patch"
		"${WORKDIR}/patches/infernity_item_hightlight_v04.patch"
		"${WORKDIR}/patches/infernity_monster_hp_bar_v02.patch"
		"${WORKDIR}/patches/mk_lmb_clicker_01.patch"
		"${WORKDIR}/patches/mk_run_in_town_smooth_01.patch"
		"${WORKDIR}/patches/maxgold.patch"
		"${WORKDIR}/patches/sergi4ua_play_sfx_on_level_up.patch"
		"${WORKDIR}/patches/all_players_on_automap.patch"
	)


src_configure() {
	local mycmakeargs=(
		-DASAN="OFF"
		-DDEBUG="$(usex debug)"
		-DDISABLE_LTO="$(usex !lto)"
		-DDIST="ON"
		-DUBSAN="OFF"
	)
	cmake_src_configure

	# Build system still doesn't reliably set release version in the build
	sed "/PROJECT_VERSION/s@-@${PV}@" -i "${BUILD_DIR}/config.h" || die
}

pkg_postinst() {
	einfo "In order to play the game you need to install the file"
	einfo "  diabdat.mpq"
	einfo "from the original game CD into the following directory:"
	einfo "  \${HOME}/.local/share/diasurgical/devilution/"
}
