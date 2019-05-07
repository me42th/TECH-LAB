    FROM ubuntu
    RUN apt-get update && apt-get install nano
    ADD ./copy_folder.tar.gz /root/
    CMD if test -d "/root/copy_folder"; then echo "The folder has been extracted"; fi