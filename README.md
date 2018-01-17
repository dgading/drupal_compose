# Drupal Compose
A simple Drupal Docker setup

## Required
Docker [MAC](https://www.docker.com/docker-mac) | [Windows](https://www.docker.com/docker-windows)

## Installing the Environment
1. Git clone the repo. I recommend using `git clone git@github.com:dgading/drupal_compose.git project-name` to keep your evironments separate. 
2. In terminal open the new directory.
3. Run `docker-compose build` to build the server container. It is a PHP 7.1 Apache build. This is based on the [Drupal Composer project](https://github.com/drupal-composer/drupal-project) and all Core and Contrib modules added in the composer.json file will be installed in this step.
4. Run `docker-compose up` to see all processes as they run or `docker-compose up -d` to run the containers in the background. 
5. In your browser, open the default server at `http://localhost:9000`.
6. Start the Drupal installation process. The default settings are: 
    1. MySql name: root
    1. MySql user: root
    1. MySql password: example
    1. In advanced dropdown, change `localhost` to `mysql`
7. Continue with installation as normal

## Using the Environment
### Logging into the docker container
1. Run `docker ps`.
1. Copy the Container ID of the php contianer (it will be named something like drupalcompose_php).
1. Run `docker exec -it <container id> bash`.
1. This will open the container at `/www/var/html`.
### Using Drush
Drush is setup to run in the Docker environment and not from your local machine. Drush is available from within the `web` directory in the PHP container.

### Using Composer
All modules and patches should be added through `composer require` or `composer install`.

### Theming
All custom module and themes should be worked on locally and their volumes will be synced with the Docker environments. 

### Using MySQL
Using a tool like Sequel Pro add the following connection details to the Standard tab. 
1. Host => localhost or 127.0.0.1
1. Username => root
1. Password => example
1. Port => 3306 or whatever you have on line 15 in docker-compose.yml

If you want command line access:
1. Find the mysql container with `docker ps`.
1. Log into the container using `docker exec -it <container id> bash`
1. Once in the container, run `mysql -u root -p`
1. If you are still using the defaults, enter `example` at the prompt and start mysqling. 