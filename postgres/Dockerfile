FROM postgres

RUN apt-get update -yqq && apt-get upgrade -yqq
RUN apt-get install sudo cron awscli -yqq
COPY ./backup.sh .
COPY ./entry.sh .
COPY ./init_setup.sh .

CMD ["bash", "entry.sh"]