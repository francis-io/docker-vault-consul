This is a test to see if nginx can round robin load balance between an arbitrary number of containers. Likely will need restarting if container count changes.

Change count to increase or decrease containers. `make start count=6 && make test && make stop`

## Requirements

* make
* docker
* docker-compose

## Credits

* I used stripped down python code from here: https://github.com/sbrakl/flask
