    FROM ubuntu
    RUN apt-get update
    ADD ./copy_folder.zip /root/
    CMD if test -d "/root/copy_folder"; then echo "The folder has been extracted"; fi