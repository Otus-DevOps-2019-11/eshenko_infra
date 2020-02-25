# eshenko_infra
eshenko Infra repository

Домашнее задание 3
==================

bastion_IP = 35.228.248.246 <br/>
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
