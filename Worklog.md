


[![Build Status](https://travis-ci.com/Gron44/Gron44_microservices.svg?branch=docker-4)](https://travis-ci.com/Gron44/Gron44_microservices)
Travis CI перенастроен на форк репозитория студента (Gron44/Gron44_microservices) [Инструкция](https://github.com/Gron44/otus-homeworks/wiki/Travis-CI)

# Gron44_microservices
Gron44 microservices repository

# Лог действий
## None network driver
```
docker run -ti --rm --network none joffotron/docker-net-tools -c ifconfig

Status: Downloaded newer image for joffotron/docker-net-tools:latest
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
```
```
docker run -ti --rm --network none joffotron/docker-net-tools -c 'ping localhost'

PING localhost (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: seq=0 ttl=64 time=0.034 ms
64 bytes from 127.0.0.1: seq=1 ttl=64 time=0.074 ms
64 bytes from 127.0.0.1: seq=2 ttl=64 time=0.072 ms
^C
--- localhost ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.034/0.060/0.074 ms
```

## Host network driver
```
docker run -ti --rm --network host joffotron/docker-net-tools -c ifconfig

br-9e7b91251ce5 Link encap:Ethernet  HWaddr 02:42:FF:3E:CA:79
          inet addr:172.18.0.1  Bcast:172.18.255.255  Mask:255.255.0.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

br-f502acd3aa01 Link encap:Ethernet  HWaddr 02:42:30:2D:F9:97
          inet addr:172.19.0.1  Bcast:172.19.255.255  Mask:255.255.0.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

docker0   Link encap:Ethernet  HWaddr 02:42:AB:41:CE:DF
          inet addr:172.17.0.1  Bcast:172.17.255.255  Mask:255.255.0.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

eth0      Link encap:Ethernet  HWaddr 00:15:5D:0F:86:B9
          inet addr:172.18.154.42  Bcast:172.18.159.255  Mask:255.255.240.0
          inet6 addr: fe80::215:5dff:fe0f:86b9%32568/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:17475 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7778 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:25402874 (24.2 MiB)  TX bytes:632520 (617.6 KiB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1%32568/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:336 (336.0 B)  TX bytes:336 (336.0 B)
```

- Запустите несколько раз (2-4)
`docker run --network host -d nginx`
- Каков результат? Что выдал docker ps? Как думаете почему?
  - все эти docker контейнеры запускаются в одной сети, используемые порты одни для всех  контейнеров. Новые nginx контейнеры не могут занять порт и завершают работу

```
2021/01/09 14:47:49 [emerg] 1#1: bind() to [::]:80 failed (98: Address already in use)
nginx: [emerg] bind() to [::]:80 failed (98: Address already in use)
2021/01/09 14:47:49 [emerg] 1#1: still could not bind()
nginx: [emerg] still could not bind()
```


 - На docker-host машине выполните команду:
`sudo ln -s /var/run/docker/netns /var/run/netns`
Теперь вы можете просматривать существующие в данный момент net-namespaces с помощью команды:
`sudo ip netns`

```
docker run -d --rm --network none nginx
docker run -d --rm --network host nginx
```
```
sudo ip netns

8b056448662f
default
```

  - Создадим docker-сети
```
docker network create back_net --subnet=10.0.2.0/24
docker network create front_net --subnet=10.0.1.0/24
```

 - Запустим контейнеры
```
docker run -d --rm --network=front_net -p 9292:9292 --name ui popadec/ui:1.0
docker run -d --rm --network=back_net --name comment popadec/comment:1.0 && \
	docker network connect front_net comment
docker run -d --rm --network=back_net --name post    popadec/post:1.0 && \
	docker network connect front_net post

docker run -d --rm --network=back_net --name mongo_db \
	--network-alias=post_db --network-alias=comment_db mongo:latest

```
## Docker-compose
 - В директории с проектом reddit-microservices, папка src, из предыдущего домашнего задания создайте файл docker-compose.yml
Выполните:
```
export USERNAME=popadec
docker-compose up -d
docker-compose ps
```
***
Основное задание:
- [x] Изменить docker-compose под кейс с множеством сетей, сетевых алиасов (стр 18).
- [x] Параметризуйте с помощью переменных окружений:
  -   порт публикации сервиса ui
  -  версии сервисов
  -  возможно что-либо еще на ваше усмотрение
- [x] Параметризованные параметры запишите в отдельный файл с расширением .env
- [x]  Без использования команд source и export docker-compose должен подхватить переменные из этого файла.
- [x]  Узнайте как образуется базовое имя проекта. Можно ли его задать? Если можно то как? Ответ добавьте в Readme.md данного ДЗ
  - Использование переменной окружения `COMPOSE_PROJECT_NAME`
  - использовать флаг `-p, --project-name` (`docker-compose -p foo up`)

Задание со *:
- [x]  Создайте docker-compose.override.yml для reddit проекта, который позволит
  -  Изменять код каждого из приложений, не выполняя сборку образа
  -  Запускать puma для руби приложений в дебаг режиме с двумя воркерами (флаги --debug и -w 2)
