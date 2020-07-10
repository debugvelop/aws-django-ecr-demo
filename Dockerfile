FROM python:3.8-slim-buster
ENV PYTHONUNBUFFERED 1

# setup working directory
RUN mkdir /django
WORKDIR /django

#setup django
RUN pip install django \
    && django-admin startproject demo . \
    && rm /django/demo/settings.py
COPY settings.py /django/demo/
VOLUME /django
EXPOSE 8000
CMD python manage.py makemigrations \
	&& python manage.py migrate \
	&& python manage.py runserver 0.0.0.0:8000