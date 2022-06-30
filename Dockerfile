FROM postgres

RUN apt-get update -yqq && apt-get upgrade -yqq
RUN apt-get install sudo cron awscli -yqq
COPY ./entry.sh .
COPY ./backup.sh .

CMD ["bash", "entry.sh"]