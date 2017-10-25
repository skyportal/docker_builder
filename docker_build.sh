#!/bin/bash

set -ex

cd skyportal
docker build -t skyportal/web .

# Run tests before uploading
docker-compose up &
# TODO this can be reduced to ~15s once `run_production` is changed to skip `npm install`
echo "Sleeping for 180 seconds while server starts"
sleep 180

echo -e "\nports:\n    app: 9000" >> test_config.yaml
PYTHONPATH=. xvfb-run -a pytest -v skyportal/tests/frontend/test_remote.py
