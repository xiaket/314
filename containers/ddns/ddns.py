#!/usr/bin/env python
import os

import requests
import xmltodict


APIKEY = os.environ["NAMESILO_APIKEY"]
IPADDR = requests.get("https://api.ipify.org?format=json").json()["ip"]
DOMAIN = "xiaket.org"
PREFIX = "home"


def main():
    params = {"domain": DOMAIN, "version": "1", "type": "xml", "key": APIKEY}
    response = requests.get(
        "https://www.namesilo.com/api/dnsListRecords", params
    )
    parsed = xmltodict.parse(response.text)
    record_id = [
        record["record_id"]
        for record in parsed["namesilo"]["reply"]["resource_record"]
        if record["host"] == ".".join([PREFIX, DOMAIN])
    ][0]

    params.update(
        {"rrid": record_id, "rrhost": PREFIX, "rrvalue": IPADDR, "rrttl": 3606}
    )
    requests.get("https://www.namesilo.com/api/dnsUpdateRecord", params)


if __name__ == "__main__":
    main()
