#!/usr/bin/env python3
import argparse
import asyncio
import json
import sys
from typing import Any

from asyncua import Client


def candidate_urls(ip: str, port: int) -> list[str]:
    base = f"opc.tcp://{ip}:{port}"
    return [f"{base}/discovery", base]


def localized_text_to_str(value: Any) -> str:
    if value is None:
        return ""
    return getattr(value, "Text", str(value))


def enum_name(value: Any) -> str:
    return getattr(value, "name", str(value))


def endpoint_to_dict(endpoint: Any) -> dict[str, Any]:
    server = getattr(endpoint, "Server", None)
    return {
        "endpoint_url": getattr(endpoint, "EndpointUrl", ""),
        "application_uri": getattr(server, "ApplicationUri", "") if server else "",
        "application_name": localized_text_to_str(
            getattr(server, "ApplicationName", None)
        )
        if server
        else "",
        "discovery_urls": list(getattr(server, "DiscoveryUrls", [])) if server else [],
        "security_mode": enum_name(getattr(endpoint, "SecurityMode", "")),
        "security_policy_uri": getattr(endpoint, "SecurityPolicyUri", ""),
    }


async def discover_endpoint_info(
    ip: str, port: int, timeout: float
) -> tuple[str, list[dict[str, Any]]]:
    errors: list[str] = []

    for url in candidate_urls(ip, port):
        client = Client(url=url, timeout=timeout)
        connected = False
        try:
            await client.connect()
            connected = True
            endpoints = await client.get_endpoints()
            return url, [endpoint_to_dict(endpoint) for endpoint in endpoints]
        except Exception as exc:  # pragma: no cover - network dependent
            errors.append(f"{url}: {exc}")
        finally:
            if connected:
                try:
                    await client.disconnect()
                except Exception:
                    pass

    raise RuntimeError(" ; ".join(errors))


def print_human(discovery_url: str, endpoint_info: list[dict[str, Any]]) -> None:
    print(f"Discovery URL used: {discovery_url}")
    print(f"Endpoints found: {len(endpoint_info)}")
    print()

    for index, item in enumerate(endpoint_info, start=1):
        print(f"[{index}]")
        print(f"  EndpointUrl       : {item['endpoint_url']}")
        print(f"  ApplicationUri    : {item['application_uri']}")
        print(f"  ApplicationName   : {item['application_name']}")
        print(f"  DiscoveryUrls     : {', '.join(item['discovery_urls']) or '-'}")
        print(f"  SecurityMode      : {item['security_mode']}")
        print(f"  SecurityPolicyUri : {item['security_policy_uri']}")
        print()


async def async_main() -> int:
    parser = argparse.ArgumentParser(
        description="Read OPC UA endpoint, application, and security metadata."
    )
    parser.add_argument("ip", help="Target OPC UA server IP or hostname")
    parser.add_argument(
        "--port", type=int, default=4840, help="Target OPC UA port (default: 4840)"
    )
    parser.add_argument(
        "--timeout", type=float, default=5.0, help="Network timeout in seconds"
    )
    parser.add_argument(
        "--json",
        action="store_true",
        help="Print the discovery result as JSON instead of human-readable text",
    )
    args = parser.parse_args()

    try:
        discovery_url, endpoint_info = await discover_endpoint_info(
            args.ip, args.port, args.timeout
        )
    except RuntimeError as exc:
        print(f"Discovery failed: {exc}", file=sys.stderr)
        return 1

    if args.json:
        print(
            json.dumps(
                {
                    "discovery_url": discovery_url,
                    "endpoints": endpoint_info,
                },
                indent=2,
            )
        )
    else:
        print_human(discovery_url, endpoint_info)

    return 0


def main() -> int:
    return asyncio.run(async_main())


if __name__ == "__main__":
    raise SystemExit(main())
