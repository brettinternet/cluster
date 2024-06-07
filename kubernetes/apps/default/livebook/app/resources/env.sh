#!/usr/bin/env bash

export LIVEBOOK_IP="${POD_IP:-$(hostname -i)}"
export LIVEBOOK_NODE="livebook_server@$LIVEBOOK_IP"
export RELEASE_NODE="$LIVEBOOK_NODE"
