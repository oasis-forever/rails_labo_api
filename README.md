## 1. Environment

* WSL(Ubuntu 20.04.1 LTS (GNU/Linux 4.19.128-microsoft-standard x86_64))
* Ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]
* Rails 6.1.3.1
* Docker version 20.10.5, build 55c4c88

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
