#!/bin/bash

install_frps() {
  sudo mkdir -p /opt/frps
  sudo install frps/* /opt/frps
  sudo chown -R nobody:nobody /opt/frps
  sudo chmod 0700 /opt/frps
  sudo setcap cap_net_bind_service=+eip /opt/frps/frps

  if type systemctl > /dev/null; then
    sudo ln -sf /opt/frps/frps.service /lib/systemd/system
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

    sudo ln -sf /opt/frps/${init_script}.init /etc/init.d/frps
    sudo service frps start
    sudo chkconfig --add frps
    sudo chkconfig frps on
  fi
}

install_frpc() {
  sudo mkdir -p /opt/frpc
  sudo install frpc/* /opt/frpc
  sudo chown -R nobody:nobody /opt/frpc
  sudo chmod 0700 /opt/frpc
  
  if type systemctl > /dev/null; then
    sudo ln -sf /opt/frpc/frpc.service /lib/systemd/system
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

    sudo ln -sf /opt/frpc/${init_script}.init /etc/init.d/frpc
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
