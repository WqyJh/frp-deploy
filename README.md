# frp

Fastly install and deploy Frp server and client.

## Prerequisite

Depends on `start-stop-daemon` or `daemonize` to damonize frp processes.

For systemd based distribution, use systemd service to deploy frp.

Otherwise use init script to deploy frp.

- For debian based distribution, `start-stop-daemon` is used to run frp which commonly installed with distribution, or you can just install it with apt.

- For centos6, you have to install the `daemonize` to run frp. (`daemonize` is also available for debian based distributions).
    ```bash
    yum install --enablerepo=extras install epel-release -y
    yum install daemonize -y
    ```

## Server

First edit `frps/frps.ini`.

You must change the auth token to an more complex one.

```ini
# auth token
token = 12345678
```

Install and run the server.

```bash
./install.sh frps
```

You can manage the frps process by `systemctl` or `service`.

## Client

First edit `frpc/frpc.ini`.

Set the server address and auth token at least.

```ini
[common]
server_addr = xxx.xxx.xxx.xxx
server_port = 7000
token = tokenstring
```

Install and run the client.

```bash
./install.sh frpc
```

You can manage the frpc process by `systemctl` or `service`.
