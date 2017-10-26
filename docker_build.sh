#!/bin/bash

set -ex

cd skyportal
docker build -t skyportal/web .

# Run tests before uploading
docker-compose up &
echo "Sleeping for 60 seconds while server starts"
sleep 60

echo -e "\nports:\n    app: 9000" >> test_config.yaml
PYTHONPATH=. xvfb-run -a pytest -v skyportal/tests/frontend/test_remote.py
