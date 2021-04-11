#!/bin/bash

docker-compose up -d;
docker exec -i chessable_app composer install;
docker exec -i chessable_db mysql -uroot -proot -e 'CREATE DATABASE IF NOT EXISTS chessable';
docker exec -i chessable_app composer dumpautoload -o;
docker exec -i chessable_app php artisan migrate && echo "Done..."