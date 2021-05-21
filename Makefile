.PHONY: dockershell

dockershell:
	docker-compose up -d nginx
	docker-compose run --service-ports --rm --entrypoint=bash php

setup:
	php artisan key:generate
	npm ci
	npm run dev

assets:
	npm ci
	npm run dev
    # npm run production

dbmigration:
	php artisan db:wipe
	php artisan migrate
	php artisan db:seed

clearcaches:
	php artisan cache:clear
	php artisan config:cache

test:
	php artisan test

# Production CI/CD targets
build-nginx:
	docker image build -t nginx:latest --target nginx .

build-fpm:
	docker image build -t php-fpm:latest --target fpm .
