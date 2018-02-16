# Contributor: Paolo Asperti <paolo@asperti.com>
# Maintainer: Paolo Asperti <paolo@asperti.com>
pkgname=acf-openpdu
pkgver=0.1
pkgrel=2
pkgdesc="ACF interface for the OpenPDU project"
url="https://github.com/openpdu/acf-openpdu"
arch="noarch"
license="GPL2"
depends="acf-core, openpdu"
makedepends=""
install="acf-openpdu.post-install"
subpackages=""
source=""
options="!check"

build() {
  :
}

package() {
	mkdir -p "$pkgdir"
#	make DESTDIR=$pkgdir install || return 1
	install -Dm644 acf-app/openpdu.menu "$pkgdir"/usr/share/acf/app/openpdu/openpdu.menu
	install -Dm644 acf-app/openpdu.roles "$pkgdir"/usr/share/acf/app/openpdu/openpdu.roles
	install -Dm644 acf-app/openpdu-controller.lua "$pkgdir"/usr/share/acf/app/openpdu/openpdu-controller.lua
	install -Dm644 acf-app/openpdu-model.lua "$pkgdir"/usr/share/acf/app/openpdu/openpdu-model.lua
	install -Dm644 acf-app/openpdu-status-html.lsp "$pkgdir"/usr/share/acf/app/openpdu/openpdu-status-html.lsp

}
