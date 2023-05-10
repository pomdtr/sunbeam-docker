#!/usr/bin/env bash

set -e

docker container ls --all --format '{{json .}}' | sunbeam query '{
    title: .Names,
    subtitle: .Image,
    accessories: [.State],
    actions: [
        { title: "Copy Container ID", "type": "copy", "text": .ID },
        { title: "Delete Container", "type": "run", reloadOnSuccess: true, command: ["docker", "container", "rm", .ID] }
    ],
}' | sunbeam query --slurp '{
    type: "list",
    items: .
}'

