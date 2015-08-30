# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit php-pear-r1

DESCRIPTION="PEAR implementation of the OAuth 1.0a specification"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/php[hash]"
RDEPEND="${DEPEND}
	dev-php/PEAR-Date
	dev-php/PEAR-HTTP_Request2
"
