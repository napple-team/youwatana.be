build:
	docker-compose -f docker-compose.production.serverside.yml build

setup:
	docker-compose -f docker-compose.production.serverside.yml up -d database redis
	sleep 10

up: setup
	docker-compose -f docker-compose.production.serverside.yml up -d

logs:
	docker-compose -f docker-compose.production.serverside.yml logs -f

down:
	docker-compose -f docker-compose.production.serverside.yml down

nginx_restart:
	docker-compose -f docker-compose.production.serverside.yml stop nginx
	docker-compose -f docker-compose.production.serverside.yml rm -f nginx
	docker-compose -f docker-compose.production.serverside.yml up -d nginx

frontend:
	docker-compose -f docker-compose.production.frontend.yml build
	docker-compose -f docker-compose.production.frontend.yml up
	rm -rf ./frontend/dist
	docker cp youwatanabe_frontend_builder:/usr/src/app/dist ./frontend/dist
	docker-compose -f docker-compose.production.frontend.yml down

.PHONY: build setup up logs down nginx_restart frontend
