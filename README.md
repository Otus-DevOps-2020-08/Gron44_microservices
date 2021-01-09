[![Build Status](https://travis-ci.com/Gron44/Gron44_microservices.svg?branch=docker-3)](https://travis-ci.com/Gron44/Gron44_microservices)
Travis CI перенастроен на форк репозитория студента (Gron44/Gron44_microservices)
[Инструкция](https://github.com/Gron44/otus-homeworks/wiki/Travis-CI)
# Gron44_microservices
Gron44 microservices repository

# ДЗ № 17 Docker-3
 - [x] Основное задание
# Задание со *
 - [x] При запуске контейнеров ( `docker run` ) задайте им переменные окружения соответствующие новым сетевым алиасам, не пересоздавая образ
***
    docker run -d \
    	--network=reddit \
    	--network-alias=new_post_db \
    	--network-alias=new_comment_db \
    	mongo:latest
    
    docker run -d \
    	--network=reddit \
    	--network-alias=new_post \
    	-e POST_DATABASE_HOST=new_post_db \
    	popadec/post:1.0
    
    docker run -d \
    	--network=reddit \
    	--network-alias=new_comment \
    	-e COMMENT_DATABASE_HOST=new_comment_db \
    	popadec/comment:1.0
    
    docker run -d \
    	--network=reddit \
    	-e POST_SERVICE_HOST=new_post \
    	-e COMMENT_SERVICE_HOST=new_comment \
    	-p 9292:9292 \
    	popadec/ui:1.0
 - [ ] Попробуйте собрать образ на основе Alpine Linux
 - [ ] Придумайте еще способы уменьшить размер образа. 
 - Multistage сборки, более активное использование минималистичных образов и удаление ненужных файлов/пакетов, 
 - [ ] Все оптимизации проводите в Dockerfile сервиса. Дополнительные варианты решения уменьшения размера образов можете оформить в  виде файла Dockerfile.<цифра> в папке сервиса
