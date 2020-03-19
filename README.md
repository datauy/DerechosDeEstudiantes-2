# Derechos de Estudiantes  
Versión 2.0.3  

Bienvenidos, el presente es un proyecto de...  

## Instalación
ssh ull  
Description:    Debian GNU/Linux 9.11 (stretch)  
Servidor Web nginx  

### RVM
(root) sudo su  
`apt install build-essential curl nodejs dirmngr  
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB  
curl -sSL https://get.rvm.io | bash -s stable --ruby  
usermod datauy -aG rvm`  

### PSQL  
https://hostadvice.com/how-to/how-to-install-postgresql-on-debian-9/  
`apt update & apt upgrade  
apt install postgresql postgresql-contrib  
vim /etc/postgresql/9.6/main/pg_hba.conf  
Cambiar acceso por clave a servidor de base de datos (peer por md5 para conexiones locales)  
service postgresql restart  
su postgres  
psql  
create database ddee;  
create user ddee with encrypted password '<pwd>’  
grant all privileges on database ddee to ddee;  
psql -U ddee -W ddee  
psql -U ddee -W ddee < ddee.sql`  

### NGINX / Passenger
(root) https://www.phusionpassenger.com/library/install/nginx/install/oss/stretch/  
`apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7  
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger stretch main > /etc/apt/sources.list.d/passenger.list'  
apt update  
apt install -y libnginx-mod-http-passenger  
service nginx restart`  
nginx config  

###NODEJS
`curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs`  

### DATAUY / Derechos de Estudiantes
`sudo su datauy  
git clone https://github.com/datauy/DerechosDeEstudiantes-2.git  
cd /DerechosDeEstudiantes-2  
git fetch  
git checkout develop  
bundle install`  
Generar base de datos (por dump o por migraciones)  
RAILS_ENV=production rake secret  
export SECRET_KEY_BASE=`rake secret` en /etc/profile (se hace en bashrc)  
https://stackoverflow.com/questions/23180650/how-to-solve-error-missing-secret-key-base-for-production-environment-rai

El documento aún está en contrucción, por lo que cualquier sugerencia o duda es bienvenida :), gracias!
