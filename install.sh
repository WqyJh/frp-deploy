#!/bin/bash

install_frps() {
  id -u frp &>/dev/null || sudo useradd -r -s /bin/false frp
  sudo mkdir -p /opt/frp
  sudo install frps/* /opt/frp
  sudo chown -R frp:frp /opt/frp
  sudo chmod 0700 /opt/frp
  sudo setcap cap_net_bind_service=+eip /opt/frp/frps

  if type systemctl > /dev/null; then
    sudo ln -sf /opt/frp/frps.service /lib/systemd/system
    sudo systemctl daemon-reload
    sudo systemctl enable frps
    sudo systemctl start frps
  else
    if [ -x /sbin/start-stop-daemon ]; then
      init_script=start-stop-daemon
    elif [ -x /usr/sbin/daemonize ]; then
      init_script=daemonize
    else
      echo "please install either start-stop-daemon or daemonize"
      exit 1
    fi

    echo "init_script=${init_script}"

    sudo ln -sf /etc/frp/${init_script}.init /etc/init.d/frps
    sudo service frps start
    sudo chkconfig --add frps
    sudo chkconfig frps on
  fi
}

install_frpc() {
  id -u frp &>/dev/null || sudo useradd -r -s /bin/false frp
  sudo mkdir -p /opt/frp
  sudo install frpc/* /opt/frp
  sudo chown -R frp:frp /opt/frp
  sudo chmod 0700 /opt/frp
  
  if type systemctl > /dev/null; then
    sudo ln -sf /opt/frp/frpc.service /lib/systemd/system
    sudo systemctl daemon-reload
    sudo systemctl enable frpc
    sudo systemctl start frpc
  else
    if [ -x /sbin/start-stop-daemon ]; then
      init_script=start-stop-daemon
    elif [ -x /usr/sbin/daemonize ]; then
      init_script=daemonize
    else
        echo "please install either start-stop-daemon or daemonize"
        exit 1
    fi

    echo "init_script=${init_script}"

    sudo ln -sf /opt/frp/${init_script}.init /etc/init.d/frpc
    sudo service frpc start
    sudo chkconfig --add frpc
    sudo chkconfig frpc on
  fi
}

help() {
  echo "Usage:"
  echo "$0 frps: Install and start the Frp Server"
  echo "$0 frpc: Install and start the Frp Client"
}

case "$1" in
  frps)
    install_frps
    ;;
  frpc)
    install_frpc
    ;;
  *)
    help
    ;;
esac
