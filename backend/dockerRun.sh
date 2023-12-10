#! /bin/bash

docker run -it --rm --network host -v ~/bee-kahve-dev/backend:/app api_env python3 api.py 
