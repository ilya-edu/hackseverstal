
Деплой
Для деплоя backed приложения необходимо на локальной машине развернуть окружение разработчика rails, для этого необходимо выполнить следуюшие шаги:
  a) Установить пакет rvm, на сайте https://rvm.io/ можно найти полные инструкции по установке
  b) Склонировать проект
  b) Установить ruby 3.2.1, сделать это можно командой rvm install 3.2.1 && rvm use 3.2.1
  с) Установить пакет libpq-dev и postgres-server-dev версии. В зависимости от операционный системы команда установки пакетов может отличатьсяю.
  d) Установить bundler, gem install bundler
  e) Установить гемы для проекта, сделать это можно командой bundle install
  f) в файл config/deploy.rb в строку set :domain (первая строка) необходимо списать ip адрес сервера

Нужно добавить фингерпирнт гита в  known host, для этого от www пользователя нужно выполнить команды.
Важно! Эти команды нужно выполнять только после добавления ключей в репозиторий!
SSH -T git@github.com

Затем можно приступать к деплою приложения на сервер:
  a) bundle exec mina setup
  b) в этот момент должны появится папки проекта на сервере.
  c) bundle exec mina production deploy


После развертывания приложений деплоить бекэнд можно командой bundle exec mina deploy

Управлять приложениями необходимо через systemd конфиги лежат в корне проекта папка systemd. Так же необходимо запустить воркер sidekiq, и consumer из соответвующих systemd


### parquet support
sudo apt update
sudo apt install -y -V ca-certificates lsb-release wget
wget https://apache.jfrog.io/artifactory/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb
sudo apt install -y -V ./apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb
sudo apt update
sudo apt install -y -V libparquet-dev # For Apache Parquet C++
sudo apt install -y -V libparquet-glib-dev # For Apache Parquet GLib (C)


### timesalce db
docker volume create lct_pgdata
docker run -d -p 5433:5432 --shm-size=1g \
-v lct_pgdata:/var/lib/postgresql/data \
-e POSTGRES_PASSWORD=password timescale/timescaledb:latest-pg15