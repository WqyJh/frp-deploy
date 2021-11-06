#!/bin/bash

uninstall_frps() {
  if type systemctl > /dev/null; then
    sudo systemctl stop frps
    sudo systemctl disable frps
    sudo unlink /lib/systemd/system/frps.service
    sudo systemctl daemon-reload
  else
    sudo service frps stop
    sudo chkconfig frps off
    sudo chkconfig --del frps
    sudo unlink /etc/init.d/frps
  fi

  sudo rm -rf /opt/frps
}

uninstall_frpc() {
  if type systemctl > /dev/null; then
    sudo systemctl stop frpc
    sudo systemctl disable frpc
    sudo unlink /lib/systemd/system/frpc.service
    sudo systemctl daemon-reload
  else
    sudo service frpc stop
    sudo chkconfig frpc off
    sudo chkconfig --del frpc
    sudo unlink /etc/init.d/frpc
  fi

  sudo rm -rf /opt/frpc
}

help() {
  echo "Usage:"
  echo "$0 frps: Uninstall and stop the Frp Server"
  echo "$0 frpc: Uninstall and stop the Frp Client"
}

case "$1" in
  frps)
    uninstall_frps
    ;;
  frpc)
    uninstall_frpc
    ;;
  *)
    help
    ;;
esac
