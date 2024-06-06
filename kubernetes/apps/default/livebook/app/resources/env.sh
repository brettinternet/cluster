#!/usr/bin/env bash

export LIVEBOOK_CLUSTER="dns:QUERY"
export RELEASE_DISTRIBUTION="name"
export LIVEBOOK_IP="${POD_IP:-$(hostname -i)}"
export POD_A_RECORD=$(echo $LIVEBOOK_IP | sed 's/\./-/g')
export LIVEBOOK_NODE="${HOSTNAME:-livebook}@$POD_A_RECORD.$NAMESPACE.pod.cluster.local"
export RELEASE_NODE="$LIVEBOOK_NODE"
