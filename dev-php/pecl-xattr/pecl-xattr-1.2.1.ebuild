# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PHP_EXT_NAME="xattr"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php5-6 php5-5 php5-4"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Allows to manipulate extended attributes on filesystems that support them. Requires libattr from Linux XFS project"
LICENSE="PHP-3"
SLOT="0"
IUSE=""
