# projectTest

Script `opcua_discovery_info.py` lay 6 truong discovery co ban cua OPC UA server:

- `EndpointUrl`
- `ApplicationUri`
- `ApplicationName`
- `DiscoveryUrls`
- `SecurityMode`
- `SecurityPolicyUri`

## Cai dat

```bash
pip install asyncua
```

## Cach chay

Mac dinh script thu `opc.tcp://IP:PORT/discovery` truoc, neu khong duoc se thu
`opc.tcp://IP:PORT`.

```bash
python3 opcua_discovery_info.py 192.168.1.100 --port 4840
```

Mac dinh output se gom cac endpoint trung `EndpointUrl/ApplicationUri/ApplicationName`
thanh 1 nhom va chi liet ke cac cap `SecurityMode + SecurityPolicyUri`, de de doc
hon.

Neu muon xem tung endpoint raw:

```bash
python3 opcua_discovery_info.py 192.168.1.100 --port 4840 --raw
```

In ra JSON:

```bash
python3 opcua_discovery_info.py 192.168.1.100 --port 4840 --json
```

## Luu y

- Script dung discovery-only API de hoi metadata endpoint, khong browse/read node du lieu.
- Mot so server hardening cao van co the chan discovery; khi do script se bao loi.
