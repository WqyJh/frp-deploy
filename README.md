# frp

Fastly install and deploy Frp server and client.

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
