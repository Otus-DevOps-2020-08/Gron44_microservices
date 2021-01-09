[![Build Status](https://travis-ci.com/Gron44/Gron44_microservices.svg?branch=docker-2)](https://travis-ci.com/Gron44/Gron44_microservices)
Travis CI перенастроен на форк репозитория студента (Gron44/Gron44_microservices)
[Инструкция](https://github.com/Gron44/otus-homeworks/wiki/Travis-CI)
# Gron44_microservices
Gron44 microservices repository

# ДЗ № 16 Docker-2
 - [x] Основное задание
 - [x] Вывод команды docker images в файл `docker-monolith/docker-1.log`
 - [x] На основе вывода команд объясните чем отличается контейнер от
образа. Объяснение допишите в файл `dockermonolith/docker-1.log`
# Задание со *
 - [x] Нужно реализовать в виде прототипа в директории `/docker-monolith/infra/`
 - [x] Поднятие инстансов с помощью Terraform, их количество задается переменной
 - [x] Несколько плейбуков Ansible с использованием динамического инвентори для установки докера и запуска там образа приложения
 - [x] Шаблон пакера, который делает образ с уже установленным Docker

## Подготовка

### скачиваем git репозиторий

    git clone https://github.com/Otus-DevOps-2020-08/Gron44_infra.git

### Переходим в основную директорию

    cd ./Gron44_microservices/dockermonolith/infra

## необходимые секреты для работы
|файл|назначение|
|--|--|
|**key.json**|ключевой файл сервисного аккаунта Yandex Cloud|
|**ubuntu / ubuntu.pub**|ssh-rsa ключи для управления виртуальными машинами|
|**env**|переменные окружения для передачи backend секретов в terraform|

## packer
    cd ./packer

    packer build -var-file variables.json docker.json`

    cd ../

## terraform

### необходимые переменные окружения
|переменная|назначение|
|--|--|
|**TFSTATE_BUCKET**|имя существующего YC s3 хранилища (ToDo: как создать)|
|**TFSTATE_REGION**|регион этого хранилища|
|**TFSTATE_ACCESS_KEY**|Key_ID ключа доступа (ToDo: как создать)|
|**TFSTATE_SECRET_KEY**|секрет ключа доступа|

### Развернуть окружение

    cd ./terraform/dev

    source ../../secrets/env

    terraform init \
    	-backend-config="bucket=${TFSTATE_BUCKET}" \
    	-backend-config="access_key=${TFSTATE_ACCESS_KEY}" \
    	-backend-config="secret_key=${TFSTATE_SECRET_KEY}" \
    	-backend-config="region=${TFSTATE_REGION}"

    terraform apply --auto-approve

    unset TFSTATE_BUCKET TFSTATE_KEY TFSTATE_ACCESS_KEY TFSTATE_SECRET_KEY TFSTATE_REGION

    cd ../../

### Скачать и запустить docker контейнеры

    cd ./ansible

    ansible-playbook playbooks/app.yml

    cd ../

### Уничтожить окружение

    cd ./terraform/dev

    terraform destroy --auto-approve
