# **ZERO TO DOCKER**
## DISCLAIMER
This Application is built using Free and Open Source Technologies, for Educational purposes, and is not intended for profit or malice. You are free to use the code base for your personal needs.

## The Application: Zero To Docker
This simple Laravel 8 Web Application, is intended to demonstrate the fundamental steps in building a fully containerized Web Application using Docker, and served securely via an NGINX webserver. The Application Design and Containerization approach, aims to provide key scaffolding fundamentals in current _Industry DevSecOps Best Practice Standards_.

## Technologies used in this project
- [laravel](https://laravel.com/docs).
- [Docker](https://www.docker.com/).
- [NGINX](https://www.nginx.com/)
- [MySQL](https://www.mysql.com/)
- [Git](https://git-scm.com/)
- [NodeJS](https://nodejs.org/en/)

## Prerequisites
In order to successfully run this project, please ensure that the following tools / technologies are installed locally on your machine:
* Docker
* PHP7.2 (or newer)
* MYSQL Community Server (Note: Don't need to install this on your machine, as we will be running it inside a Docker Container.)
* Git (Version Control System):
    * Ensure to create a Github Account (It is free)
* Composer (Dependency Manager for PHP)
* NPM (Javascript Package Manager) Note: _This will be installed with NodeJS above._

## Steps To Run the Application Locally
1. Create a new parent directory for you to store this project. Eg. 'MyProjects'
2. Go into 'MyProjects', open that folder in the command-line, and run the following _git command_ to _clone_ the project into your local machine.
```
git clone https://github.com/DintogaeSpiritEagle/ztd-app.git ztd
```
When completed. You will now have a new folder named _ztd_ which contains all the project files. Go into this directory to confirm that all the files are there.
3. Copy `.env.example` to `.env`.
```
cp .env.example .env
```
4. Update the `DB_*` parameters in the `.env` file:
```
DB_CONNECTION=mysql
DB_HOST=mariadb
DB_PORT=3306
DB_DATABASE=ztd
DB_USERNAME=ztd
DB_PASSWORD=ztd
```
5. Check your _docker-compose.yml_ file to verify that it contains the necessary configurations to build the following containers:
* _nginx_ Web Server Container
* _php_ Web Application Container
* _mariadb_ Mariadb (MYSQL) Database Container
6. Build your docker containers and provision your new environments using the commands below, whilst in your _ztd_ directory:
Note: 
* `dockeshell` and `setup` are two commands in your `Makefile` that will build and setup the necessary dependencies for your application.
```
$ make dockershell setup
docker-compose up -d nginx
Creating mariadb ... done
Creating php     ... done
Creating nginx   ... done
docker-compose run --service-ports --rm --entrypoint=bash php
Creating ztd2_php_run ... done
root@3cc116324d9e:/var/www/html#
```
Run the `make dbmigration` instruction inside your `php` container built above, followed by the command `exit`, to allow `npm` to compile the remaining javascript assets:
```
..
..
root@3cc116324d9e:/var/www/html# make dbmigration
php artisan db:wipe
Dropped all tables successfully.
php artisan migrate
Migration table created successfully.
Migrating: 2014_10_12_000000_create_users_table
Migrated:  2014_10_12_000000_create_users_table (17.49ms)
Migrating: 2014_10_12_100000_create_password_resets_table
Migrated:  2014_10_12_100000_create_password_resets_table (14.66ms)
Migrating: 2019_08_19_000000_create_failed_jobs_table
Migrated:  2019_08_19_000000_create_failed_jobs_table (15.87ms)
Migrating: 2019_12_14_000001_create_personal_access_tokens_table
Migrated:  2019_12_14_000001_create_personal_access_tokens_table (23.42ms)
php artisan db:seed
Database seeding completed successfully.
root@3cc116324d9e:/var/www/html# exit
exit
php artisan key:generate
Application key set successfully.
npm ci
npm WARN deprecated urix@0.1.0: Please see https://github.com/lydell/urix#deprecated
npm WARN deprecated resolve-url@0.2.1: https://github.com/lydell/resolve-url#deprecated
npm WARN deprecated chokidar@2.1.8: Chokidar 2 will break on node v14+. Upgrade to chokidar 3 with 15x less dependencies.
npm WARN deprecated fsevents@1.2.13: fsevents 1 will break on node v14+ and could be using insecure binaries. Upgrade to fsevents 2.
...
...
...
webpack compiled successfully

```
7. In your terminal, run `docker ps -a` to see the containers that you just created. Confirm that they are all running.
```
CONTAINER ID   IMAGE        COMMAND                  CREATED         STATUS                   PORTS                  NAMES
07f0b973da07   nginx        "/docker-entrypoint.…"   4 seconds ago   Up 3 seconds             0.0.0.0:8080->80/tcp   nginx
86fde0142d39   ztd2_php     "docker-php-entrypoi…"   5 seconds ago   Up 3 seconds             9000/tcp               php
402839fe349a   mariadb:10   "docker-entrypoint.s…"   6 seconds ago   Up 5 seconds (healthy)   3306/tcp               mariadb
```
8. Go to the browser and _Register_ a new user: `[Register New User](http://localhost:8080/register)`
9. Login with your _Newly Created User_ via: `[Login](http://localhost:8080/login)`
10. To stop your running containers, run the following `docker` command:
```
docker stop nginx php mariadb && docker rm nginx php mariadb
```
And to rebuild your docker containers, do steps 1-9 again.

Enjoy!
