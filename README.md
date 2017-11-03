# Byond2IP 

A web scraper that can convert `byond://BYOND.world.[123456789]` into `[IP ADDR]:[PORT]` format.

## About

Byond2IP was created to facilitate requirements for a larger project that will be able to track and graph individual players movements on the Byond hub.

## Configuration

While this project is currently only monitoring Space Station 13 servers the byond hub URL can be modified in `./scripts/GetByond.sh`. 

## Converting

To convert a single Byond URL into an IP address you can add it to `./config/worlds.txt` in the format:

```
[Server Name]:[Byond DIGITS]
-->
Test Server:123456789
``` 

Alternatively the list can be automatically generated from the byond hub by running `./scripts/generate.sh`.

## How it works

Byond2IP starts up a minimal Byond application that reads the list of worlds from `./config/worlds.txt` and then uses `world.Export()` to query servers with the `?ping` command via `world/Topic()`. Through this exchange the byond hub decodes the Byond URL and a connection is opened to the actual IP address. This address is then retrieved by referencing the output of `netstat`. 

## Future Work

Byond2IP should store a persistant list of IP addresses it finds rather than wiping the whole list and starting again each time. 
