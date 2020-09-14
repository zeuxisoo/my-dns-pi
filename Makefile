CADDY_CONTAINER_ID=$(shell docker ps | grep caddy | awk '{print $$1;}')

all:
	@echo
	@echo "Command           : Description"
	@echo "----------------- : ------------------"
	@echo "make caddy-reload : Reload the caddy service configuration files"
	@echo

caddy-reload:
	@sudo docker exec $(CADDY_CONTAINER_ID) caddy reload --config /etc/caddy/Caddyfile --adapter caddyfile
