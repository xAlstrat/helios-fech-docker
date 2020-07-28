## Installation

* Install docker & docker-compose
* Setup .env

### Development

To run the entire project with all its containers and services:

    docker-compose up -d --build backend_dev
    
### Production

To run the entire project with all its containers and services:

    docker-compose up -d --build backend 

## Utilities

Docker services are:

* backend (helios running in production. PORT 8000)
* backend_dev (helios running in development. PORT 8000)
* nginx (PORT 80/443)
* rabbitmq
* celery_worker

### Reset DB and create first user

For dev:

    bash ./reset.sh -d
    
For production:

    bash ./reset.sh
    
### Show logs

    docker-compose logs -f {{service}}
    
### Execute manage.py command

Only for `backend` and `backend_dev`:

    docker-compose exec {{service}} python manage.py {{command}}
    
### Build container with new code

    docker-compose up -d --build {{service}}
    
### Stop all services

    docker-compose down