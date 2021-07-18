# Derechos de Estudiantes  
Versión 2.2.0  

<p align="center">
<img  src="https://img.shields.io/github/license/datauy/DerechosDeEstudiantes-2">
<img  src="https://img.shields.io/github/last-commit/datauy/DerechosDeEstudiantes-2">
<img  src="https://img.shields.io/website?up_color=green&up_message=online&url=https%3A%2F%2Fderechosdeestudiantes.edu.uy">
<a href="https://sonarcloud.io/dashboard?id=datauy_DerechosDeEstudiantes-2" target="_blank"><img src="https://sonarcloud.io/api/project_badges/measure?project=datauy_DerechosDeEstudiantes-2&metric=alert_status"></a>
</p>

Bienvenides,  
Esta herramienta fue co-creada en por el Consejo de Educación Secundaria (CES), Consejo de Educación Técnico Profesional (CETP/UTU), Administración Nacional de Educación Pública (ANEP), UNICEF Uruguay y DATA Uruguay, en base a demandas surgidas de las Mesas Representativas de estudiantes de Secundaria y permite a estudiantes, padres y actores educativos consultar preguntas con información actualizada y completa sobre derechos de estudiantes.  

Además brinda una herramienta de consulta directa a estudiantes, para que puedan conocer más sobre sus derechos y recibir respuestas personalizadas a sus problemas e inquietudes.
En los casos donde la información buscada no se encuentra dentro del contenido existente, ni las consultas anteriores de estudiantes, un sencillo formulario permite enviar una consulta, que es recibida por el consejo correspondiente, que canaliza o realiza las consultas necesarias.  

La herramienta evoluciona con la participación de los estudiantes, actualizando su contenido para reflejar las inquietudes planteadas, así como los nuevos derechos adquiridos.

## Datos Abiertos
Desde la versión 2.2.0 hemos incorporado la publicación de datos anonimizados de las consultas, las respuestas, dudas, y los derechos de los estudiantes del Uruguay.
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
