setup:
	docker volume create my_data

install:
	rm -rf api/node_modules
	docker-compose -f docker-compose.builder.yml run --rm install

start:
	docker-compose up

stop:
	docker-compose down
