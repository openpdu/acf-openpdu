MYDIR=$(cd "$(dirname "$0")/../acf-app" ; pwd -P)
docker run --rm -d -v "$MYDIR:/usr/share/acf/app/openpdu/" -p 443 acf-openpdu:latest

