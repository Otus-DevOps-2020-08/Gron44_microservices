
[![Build Status](https://travis-ci.com/Gron44/Gron44_microservices.svg?branch=docker-4)](https://travis-ci.com/Gron44/Gron44_microservices)
Travis CI перенастроен на форк репозитория студента (Gron44/Gron44_microservices) [Инструкция](https://github.com/Gron44/otus-homeworks/wiki/Travis-CI)

# Gron44_microservices
Gron44 microservices repository



# ДЗ № 18 Docker-4

Основное задание:
- [x] Изменить docker-compose под кейс с множеством сетей, сетевых алиасов (стр 18).
- [x] Параметризуйте с помощью переменных окружений:
  - порт публикации сервиса ui
  - версии сервисов
  - возможно что-либо еще на ваше усмотрение
- [x] Параметризованные параметры запишите в отдельный файл с расширением .env
- [x] Без использования команд source и export docker-compose должен подхватить переменные из этого файла.
- [x] Узнайте как образуется базовое имя проекта. Можно ли его задать? Если можно то как? Ответ добавьте в Readme.md данного ДЗ
  - Использование переменной окружения `COMPOSE_PROJECT_NAME`
  - использовать флаг `-p, --project-name` (`docker-compose -p foo up`)

Задание со *:
- [x]  Создайте docker-compose.override.yml для reddit проекта, который позволит
  -  Изменять код каждого из приложений, не выполняя сборку образа
  -  Запускать puma для руби приложений в дебаг режиме с двумя воркерами (флаги --debug и -w 2)

## Как запустить проект:
### скачиваем git репозиторий с нужной веткой
    git clone --single-branch --branch docker-4 https://github.com/Otus-DevOps-2020-08/Gron44_infra.git

### Переходим в основную директорию
    cd ./Gron44_microservices/src

### необходимые секреты для работы
|файл|назначение|
|--|--|
|`.env`|файл с необходимымы переменными окружения для `docker-compose.yml`, пример файла `.env.example`|

### docker
Создаем отдельный volume для БД

    docker volume create reddit_db

### docker-compose
    docker-compose up -d

## Как проверить работоспособность:
Перейти по ссылке \<IP docker хоста\>:9292

## PR checklist
 - [x] Выставил label с темой домашнего задания
