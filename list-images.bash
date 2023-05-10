#!/usr/bin/env bash

set -e

docker image ls --all --format '{{json .}}' | sunbeam query '{
    title: "\(.Repository):\(.Tag)",
    accessories: [.Size],
    actions: [
        { title: "Copy Image ID", "type": "copy", "text": .ID },
        { title: "Delete Image", "type": "run", reloadOnSuccess: true, command: ["docker", "image", "rm", .ID] }
    ],
}' | sunbeam query --slurp '{
    type: "list",
    items: .
}'
