setup:
	docker volume create my_data

install:
	rm -rf api/node_modules
	docker-compose -f docker-compose.builder.yml run --rm install

up:
	docker-compose up

down:
	docker-compose down
