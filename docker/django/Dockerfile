# Use an official Python runtime as a parent image
FROM python:2.7
LABEL maintainer="hello@wagtail.io"

# Set environment varibles
ENV PYTHONUNBUFFERED 1
ENV DJANGO_ENV dev

RUN apt-get update && apt-get install -y python-pip

COPY ./requirements.txt /code/requirements.txt
RUN pip install --upgrade pip
# Install any needed packages specified in requirements.txt
# --ignore-installed
RUN pip install -r /code/requirements.txt
RUN pip install gunicorn

# Copy the current directory contents into the container at /code/
COPY . /code/
# Set the working directory to /code/
WORKDIR /code/

RUN cp docker/django/django-entrypoint-dev.sh / \
    && cp docker/django/django-entrypoint-prod.sh / \
    && cp docker/django/celery-entrypoint.sh / \
    && chmod +x /django-entrypoint-dev.sh / \
    && chmod +x /django-entrypoint-prod.sh / \
    && chmod +x /celery-entrypoint.sh