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
When completed. You will now have a new folder named _ztd_ which contains all the project files. Got into this directory to confirm that all the files are there.
3. Check your _docker-compose.yml_ file to verify that it contains the necessary configurations to build the following containers:
* _nginx_ Web Server Container
* _php_ Web Application Container
* _mariadb_ Mariadb (MYSQL) Database Container
4. Run the following docker-compose, whilst in the _ztd_ directory, to build the containers:
```
docker-compose up --build
```
5. In your terminal, run `docker ps -a` to see the containers that you just created. Confirm that they are all running.
6. In your terminal, run the `setup` step from the _Makefile_ using the following docker-compose command:
```
docker exec php make setup
```
Note: _This command will execute the following setup commands contained in the _Makefile_:
```
setup:
	php artisan key:generate    --- This will generate a unique key for your Laravel Application
	php artisan migrate         --- This will run the Database Migrations.
	php artisan db:seed         --- This will pre-populate your Database with any pre-configured data.
	npm ci                      --- CI stands for continuous integration and npm ci is used to install all exact version dependencies or devDependencies from a package-lock.json file
	npm run dev                 --- Compiles all scripts
```
7. Go to the browser and _Register_ a new user: `[Register New User](http://localhost:8080/register)`
8. Login with your _Newly Created User_ via: `[Login](http://localhost:8080/login)`

Enjoy!
