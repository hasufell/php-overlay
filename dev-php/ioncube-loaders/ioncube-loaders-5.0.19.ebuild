# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PHP_EXT_NAME="ioncube_loader"
PHP_EXT_ZENDEXT="yes"
PHP_EXT_INI="yes"

USE_PHP="php5-4 php5-5 php5-6"

inherit php-ext-source-r2

MY_P="${PN}"
MY_ARCH=${ARCH/amd64/x86-64}

DESCRIPTION="PHP extension that support for running PHP scripts encoded with ionCube's encoder"
HOMEPAGE="http://www.ioncube.com/"
SRC_URI="
	amd64? (
		http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.bz2 -> ${P}-amd64.tar.bz2
	)
	x86? (
		http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86.tar.bz2 -> ${P}-x86.tar.bz2
	)"

LICENSE="${PN}"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="
	!dev-php/eaccelerator
	!dev-php/PECL-apc"
DEPEND="${RDEPEND}"

PHP_LIB_DIR="/usr/share/php/${PN}"

S="${WORKDIR}/ioncube"
PHP_EXT_S=${S}
DOCS="README.txt"

pkg_setup() {
	PHP_VER="$(best_version =dev-lang/php-5* | sed -e 's#dev-lang/php-\([0-9]*\.[0-9]*\)\..*#\1#')"
}

src_unpack() {
	unpack ${A}

	IONCUBE_SO_FILE="${PHP_EXT_NAME}_lin_${PHP_VER}.so"
	cd "${S}" || die
	mkdir modules || die
	mv ${IONCUBE_SO_FILE} "modules/${PHP_EXT_NAME}.so" || die

	local slot orig_s="${PHP_EXT_S}"
	for slot in $(php_get_slots); do
		cp -r "${orig_s}" "${WORKDIR}/${slot}" \
			|| die "Failed to copy source ${orig_s} to PHP target directory"
	done
}

src_prepare() { :; }

src_configure() { :; }

src_compile() { :; }

src_install() {
	#Get from php-ext-source-r2_src_install
	local slot
	for slot in $(php_get_slots); do
		php_init_slot_env ${slot}

		# Let's put the default module away
		insinto "${EXT_DIR}"
		newins "modules/${PHP_EXT_NAME}.so" "${PHP_EXT_NAME}.so" \
			|| die "Unable to install extension"

		local doc
		for doc in ${DOCS} ; do
			[[ -s ${doc} ]] && dodoc ${doc}
		done
	done
	php-ext-source-r2_createinifiles
}
