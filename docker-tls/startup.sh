sudo ./gen_key.sh
tar zxvf tls-client-certs.tar.gz
cp ./ca.pem ../main/CertKey/ca.pem
cp ./cert.pem ../main/CertKey/cert.pem
cp ./key.pem ../main/CertKey/key.pem
CONF=/lib/systemd/system/docker.service
set_key_value() {
  local key=${1}
  local value='/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock -H tcp://0.0.0.0:2375 -H unix://var/run/docker.sock -D --tlsverify --tlscert=/etc/docker/certs.d/server-cert.pem --tlskey=/etc/docker/certs.d/server-key.pem --tlscacert=/etc/docker/certs.d/ca.pem'
      echo "setting $CONF : $key = $value"
      value="$(echo "${value}" | sed 's|[&]|\\&|g')"
      sed -i "s|^[#]*[ ]*${key}\([ ]*\)=.*|${key} = ${value}|" ${CONF}
}
set_key_value "ExecStart"
sudo systemctl daemon-reload && sudo systemctl restart docker
