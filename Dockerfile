FROM postgres:11
RUN  apt-get update && \
     apt-get install awscli -y
WORKDIR /app
COPY ./postgres_to_S3.sh /app
RUN chmod +x postgres_to_S3.sh
CMD ["bash", "postgres_to_S3.sh"]
