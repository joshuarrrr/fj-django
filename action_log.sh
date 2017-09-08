#!/bin/bash
# Log from following part 1 of http://forjournalism.github.io/courses/django/

# intall postgresql
# sudo apt-get install postgresql
# http://stackoverflow.com/questions/43471508/how-to-install-postgresql-9-3-3-client-on-linux-mint
# don't us IPv6 for apt:
sudo vim /etc/gai.conf
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-14-04
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib
sudo -i -u postgres

# make directory and clone tutorial project
mkdir fj	
cd fj
git clone https://github.com/ForJournalism/fj-django.git

# setup virtual environment for tutorial
mkvirtualenv inspections
workon inspections

# install requirements
# pip install django south django-tastypie
# http://stackoverflow.com/questions/29647602/there-is-no-south-database-module-south-db-postgresql-psycopg2-for-your-databa
pip install django django-tastypie
pip install psycopg2
pip freeze > requirements.txt

# create django project and apps
django-admin.py startproject inspections
django-admin.py startapp restaurant
django-admin.py startapp inspection
add2virtualenv .
add2virtualenv inspections
export DJANGO_SETTINGS_MODULE=inspections.settings
git commit -m "Initial Django setup. Add restaurant and inspection apps."

# change default settings
subl settings.py 

# create postgres database and user
createdb inspections
createuser inspections
psql inspections
# http://stackoverflow.com/questions/8167602/django-connection-to-postgresql-peer-authentication-failed
# http://stackoverflow.com/questions/11192134/connect-to-a-db-using-psycopg2-without-password
sudo subl /etc/postgresql/9.3/main/pg_hba.conf 
# https://serverfault.com/questions/61383/reloading-postgresql-after-configuration-changes
sudo /etc/init.d/postgresql reload
# https://simpleisbetterthancomplex.com/tutorial/2016/06/27/how-to-use-djangos-built-in-login-system.html
django-admin.py createsuperuser
django-admin.py schemamigration
# http://stackoverflow.com/questions/29683494/what-should-i-use-instead-of-syncdb-in-django-1-9
django-admin.py makemigrations
django-admin.py migrate
django-admin.py runserver
git commit -m "create initial models, make migrations, and add to admin"
