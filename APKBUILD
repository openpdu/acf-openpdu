# Contributor: Paolo Asperti <paolo@asperti.com>
# Maintainer: Paolo Asperti <paolo@asperti.com>
pkgname=acf-openpdu
pkgver=0.1
pkgrel=1
pkgdesc="Linux installation caching system"
url="https://github.com/paspo/installinux"
arch="noarch"
license="GPL2"
depends="acf-core"
makedepends=""
install="acf-openpdu.post-install"
subpackages=""
source=""

package() {
	mkdir -p "$pkgdir"
}

package() {
#	make DESTDIR=$pkgdir install || return 1
	install -Dm644 etc/openpdu/openpdu.conf "$pkgdir"/etc/openpdu/openpdu.conf
	install -Dm755 etc/local.d/openpdu.start "$pkgdir"/etc/local.d/openpdu.start

	install -Dm644 acf-app/openpdu.menu "$pkgdir"/usr/share/acf/app/openpdu/openpdu.menu
	install -Dm644 acf-app/openpdu.roles "$pkgdir"/usr/share/acf/app/openpdu/openpdu.roles
	install -Dm644 acf-app/openpdu-controller.lua "$pkgdir"/usr/share/acf/app/openpdu/openpdu-controller.lua
	install -Dm644 acf-app/openpdu-model.lua "$pkgdir"/usr/share/acf/app/openpdu/openpdu-model.lua
	install -Dm644 acf-app/openpdu-status-html.lsp "$pkgdir"/usr/share/acf/app/openpdu/openpdu-status-html.lsp

}
