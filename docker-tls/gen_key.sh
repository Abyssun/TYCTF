#!/bin/bash
#
# -------------------------------------------------------------
# 自动创建 Docker TLS 证书
# -------------------------------------------------------------
# 以下是配置信息
# --[BEGIN]------------------------------
IP="192.168.48.202"
PASSWORD="b1ackc4tyyds"
COUNTRY="CN"
STATE="HUBEI"
CITY="WUHAN"
ORGANIZATION="XXSSHH"
ORGANIZATIONAL_UNIT="Dev"
COMMON_NAME="$IP"
EMAIL="xxxxxxxxx@163.com"
# --[END]--
# Generate CA key
openssl genrsa -aes256 -passout "pass:$PASSWORD" -out "ca-key.pem" 4096
# Generate CA
openssl req -new -x509 -days 365 -key "ca-key.pem" -sha256 -out "ca.pem" -passin "pass:$PASSWORD" -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/OU=$ORGANIZATIONAL_UNIT/CN=$COMMON_NAME/emailAddress=$EMAIL"
# Generate Server key
openssl genrsa -out "server-key.pem" 4096
# Generate Server Certs.
openssl req -subj "/CN=$COMMON_NAME" -sha256 -new -key "server-key.pem" -out server.csr
echo "subjectAltName = IP:$IP,IP:127.0.0.1" >> extfile.cnf
echo "extendedKeyUsage = serverAuth" >> extfile.cnf
openssl x509 -req -days 365 -sha256 -in server.csr -passin "pass:$PASSWORD" -CA "ca.pem" -CAkey "ca-key.pem" -CAcreateserial -out "server-cert.pem" -extfile extfile.cnf
# Generate Client Certs.
rm -f extfile.cnf
openssl genrsa -out "key.pem" 4096
openssl req -subj '/CN=client' -new -key "key.pem" -out client.csr
echo extendedKeyUsage = clientAuth >> extfile.cnf
openssl x509 -req -days 365 -sha256 -in client.csr -passin "pass:$PASSWORD" -CA "ca.pem" -CAkey "ca-key.pem" -CAcreateserial -out "cert.pem" -extfile extfile.cnf
rm -vf client.csr server.csr
chmod -v 0400 "ca-key.pem" "key.pem" "server-key.pem"
chmod -v 0444 "ca.pem" "server-cert.pem" "cert.pem"
# 打包客户端证书
mkdir -p "tls-client-certs"
cp -f "ca.pem" "cert.pem" "key.pem" "tls-client-certs/"
cd "tls-client-certs"
tar zcf "tls-client-certs.tar.gz" *
mv "tls-client-certs.tar.gz" ../
cd ..
rm -rf "tls-client-certs"
# 拷贝服务端证书
mkdir -p /etc/docker/certs.d
cp "ca.pem" "server-cert.pem" "server-key.pem" /etc/docker/certs.d/
