# eshenko_infra
eshenko Infra repository

Домашнее задание 7
==================

Протестирована работа модулей <br/>
Конфигурация разбита на окружения (stage, prod) <br/>
Создана корзина для хранения состояния terraform (backend) <br/>
Настроена проверка состояния из корзины <br/>
Добавлены провижинеры для запуска приложения

При запуске terraform из разных мест возникает ошибка, так как при запуске первого создается файл tflock, а при запуске второго проверяется наличие такого файла, блокировка срабатывает корректно.

Домашнее задание 6
==================

После добавления SSH ключа через Веб-интерфейс, при использовании metadata(ssh-keys) в ресурсе google_compute_instance, проблем не возникает.
Но при использовании отдельного ресурса google_compute_project_metadata_item, после обновления конфигурации, SSH ключ, добавленный через Веб-интерфейс удаляется и заменяется ключами указанным в google_compute_project_metadata_item.

Параметризованы основные значения.
Отформатированы конфиги (terraform fmt).
Добавлено создание ssh ключей для разных пользователей.


Домашнее задание 5
==================

В рамках основного задания создан образ reddit-base с использованием packer шаблона. <br/>
Запуск построения образа: <br/>
packer build -var-file=./packer/variables.json ./packer/ubuntu16.json

В рамках самостоятельного заданмя 1 в шаблон добавлены пользовательские переменные. <br/>
В рамках самостоятельного задания 2 добавлен файл переменных variables.json (variables.json.example). <br/>
В рамках самостоятельного задания 3 добавлены новые пользовательские переменные. <br/>
В рамках задания со звездочкой 1 создан образ reddit-full поверх созданного в основном задании образа reddit-base.

Запуск построения образа: <br/>
packer build -var-file=./packer/files/variables.json ./packer/immutable.json

В рамках задания со звездочкой 2 создан скрипт config-scripts/create-reddit-vm.sh для создания экзмепляра на основе образа reddit-full.



Домашнее задание 4
==================

testapp_IP = 35.228.215.244
testapp_port = 9292

Самостоятельное задание
-----------------------

Скрипты install_ruby.sh, install_mongodb.sh, deploy.sh, startup.sh  приложены

Команда для запуска со startup скриптом:

    gcloud compute instances create reddit-app \
      --boot-disk-size=10GB \
      --image-family ubuntu-1604-lts \
      --image-project=ubuntu-os-cloud \
      --machine-type=g1-small \
      --tags puma-server \
      --restart-on-failure \
      --metadata-from-file startup-script=./startup.sh

Дополнительное задание
----------------------

Создание правила брандмауэра через консоль:

    gcloud compute firewall-rules create default-puma-server \
      --network default \
      --direction ingress \
      --action allow \
      --target-tags puma-server \
      --source-ranges 0.0.0.0/0 \
      --rules tcp:9292 \
      --no-disabled




Домашнее задание 3
==================

bastion_IP = 35.228.248.246
someinternalhost_IP = 10.166.0.3


Самостоятельное задание
-----------------------

Для доступа к someinternalhost напрямую, необходимо добавить следующие настройки в ~/.ssh/config

    Host bastion
      User alex
      Hostname 35.228.248.246
      Port 22
      IdentityFile ~/.ssh/alex
      ForwardAgent yes

    Host someinternalhost
      User alex
      Hostname 10.166.0.3
      Port 22
      IdentityFile ~/.ssh/alex
      ForwardAgent yes
      ProxyJump alex@35.228.248.246

После чего к серверам можно подключаться командами
ssh bastion и ssh someinternalhost

Дополнительное задание
----------------------

Для использования валидного сертификата достаточно в поле Lets Encrypt Domain в разделе Settings
добавить адрес 35-228-248-246.sslip.io или 35-228-248-246.xip.io <br/>
Однако воспроизвести это не удалось, так как закончился лимит выпуска сертификатов для данного домена.

Ошибка:
"Error creating new account :: too many registrations for this IP: see https://letsencrypt.org/docs/rate-limits/"
