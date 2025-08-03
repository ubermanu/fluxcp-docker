#!/bin/sh

php -S 0.0.0.0:80 -t /fluxcp &
pid=$!

# Graceful shutdown trap
trap "echo 'Stopping...'; kill $pid; wait $pid" SIGTERM SIGINT

wait $pid
