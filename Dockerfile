FROM nginx/nginx:1.10

RUN apt-get clean 
RUN apt-get update 
RUN apt-get install -y vim spawn-fcgi fcgiwrap libswitch-perl libany-uri-escape-perl build-essential wget curl fortune cowsay
RUN cpan URI::Encode::XS

RUN sed -i 's/www-data/nginx/g' /etc/init.d/fcgiwrap
RUN chown nginx:nginx /etc/init.d/fcgiwrap

RUN mkdir -p /var/log/nginx/web
RUN mkdir -p /var/www
RUN mkdir -p /var/cache/nginx
RUN chmod 777 /var/cache/nginx
RUN chown nginx:nginx /var/log/nginx/web
RUN chown nginx:nginx /var/www
RUN chmod 777 /var/run/

ADD ./vhost.conf /etc/nginx/conf.d/default.conf
ADD fun.pl /var/www
ADD index.html /var/www
ADD quotes /usr/share/games/fortunes

RUN strfile -c % /usr/share/games/fortunes/quotes /usr/share/games/fortunes/quotes.dat

EXPOSE 80

CMD /etc/init.d/fcgiwrap start && nginx -g 'daemon off;'

