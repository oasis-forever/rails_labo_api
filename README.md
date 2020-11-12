## 1. Environment

* WSL(Ubuntu 20.04.1 LTS (GNU/Linux 4.19.128-microsoft-standard x86_64))
* ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-linux]
* Rails 6.0.3.4
* Docker version 19.03.13, build 4484c46d9d

## 2. Clone the repository

```bash
$ git clone git@github.com:oasis-forever/rails_labo_api.git
```

## 3. Docker

### 4-1. Build constainers

* Build container of `db` and `app`

```bash
$ docker-compose up -d
```

### 4-2. MySQL

```bash
$ docker-compose exec db mysql -u root -p
password:
```

```sql
/* Switch database */
mysql> USE mysql;
/* Check user and hostname before making a change */
mysql> SELECT user, host FROM user WHERE user = 'root';
/* Allow any host to access to MySQL server */
mysql> UPDATE user SET host = '%' WHERE user = 'root';
/* Check user and hostname after making a change */
mysql> SELECT user, host FROM user WHERE user = 'root';
/* Exit */
mysql> exit;
```

### 4-3. Rails

#### 4-3-1. Create database

```bash
$ docker-compose exec app bin/rails db:create
```

#### 4-3-2. Access `localhost:5000`

![Yay! You're on Ruby on Rails](https://github.com/oasis-forever/rails_labo_api/blob/master/public/yay!-you're-on-rails!.png)
