This is a test to see if nginx can round robin load balance between an arbitrary number of containers. Likely will need restarting if container count changes.

Change count to increase or decrease containers. `make start count=6 && make test && make stop`

## Requirements

* make
* docker
* docker-compose

## Credits

* I used stripped down python code from here: https://github.com/sbrakl/flask

```
 # nginx_loadbalancer:
  #   container_name: lb
  #   image: nginx:alpine
  #   ports:
  #     - 8500:8500
  #   volumes:
  #     - ./nginx-proxy/nginx.conf:/etc/nginx/nginx.conf:ro
  #   depends_on:
  #     - consul
  #     - consul-workers
```