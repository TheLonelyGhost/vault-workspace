# Vault Workspace

This project exists to act as scratch paper. In other words, it is some sort of throwaway workspace for tinkering with all things (Hashicorp) Vault when it is setup in a production-like manner.

## Features

- Easy setup and teardown scripts with `setup.sh` and `destroy.sh`
- Completely ephemeral data
- Lightweight: running as containers instead of VMs
- Writes out connection information locally to work with local `vault` CLI tool
- Load-balancer entrypoint to the docker network with HAProxy container

## Roadmap

These are the things that still need to be done for a fully-fledged setup:

- [ ] Consul actually logging the Vault service operators
- [ ] Vault namespaces (enterprise mode trial)
- [ ] Consul DNS being the default network discovery mechanism
- [ ] Vault communication over TLS
- [ ] Windows support

## Authors

- David Alexander (<opensource@thelonelyghost.com>)
