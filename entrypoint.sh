#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
# rm -f /Getting-Start-in-Rails/myapp/tmp/pids/server.pid

echo 'alias "ll=ls -lht --color"' >> ~/.bashrc
cp /Getting-Start-in-Rails/Gemfile /Getting-Start-in-Rails/myapp
# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"