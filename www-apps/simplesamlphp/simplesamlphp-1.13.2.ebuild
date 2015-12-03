# Copyright 2015 Julian Ospald
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils webapp

DESCRIPTION="An award-winning application written in native PHP that deals with authentication"
HOMEPAGE="https://simplesamlphp.org"
SRC_URI="https://simplesamlphp.org/res/downloads/simplesamlphp-${PV}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-lang/php[cgi,cli,crypt,json,ldap,mhash,mysql,mysqli]
	dev-libs/openssl:0
	dev-php/PEAR-XML_Parser
	dev-php/pecl-radius
	dev-php/php-openid
	sys-libs/zlib
"
DEPEND=""

need_httpd_cgi

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r bin dictionaries lib modules schemas config templates vendor www

	insinto /etc/simplesamlphp
	doins -r attributemap config templates "${FILESDIR}"/apache.conf

	eshopts_push -s nullglob
	local config_files=(
		"${MY_HTDOCSDIR}"/config/*
		"${MY_HTDOCSDIR}"/templates/*
	)
	eshopts_pop

	webapp_configfile ${config_files[@]}

	webapp_src_install
}
