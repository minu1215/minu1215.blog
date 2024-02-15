FROM ubuntu:latest

WORKDIR /app
COPY . /app/minu1215.blog
RUN apt update
RUN apt install -y nginx
RUN apt install -y git
RUN apt install -y cron

WORKDIR /var/www
RUN ln -s /app/minu1215.blog .
RUN rm -rf html
RUN mv minu1215.blog html

COPY blog-pull-cronjob /etc/cron.d
RUN crontab /etc/cron.d/blog-pull-cronjob
RUN crontab -l

EXPOSE 80
WORKDIR /
COPY start.sh /app
RUN chmod 777 /app/start.sh
CMD ./app/start.sh;
