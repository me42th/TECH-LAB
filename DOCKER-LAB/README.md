#CENÁRIO 1

##Dockerfile

Um container ubuntu atualizado e com o tree instalado

<pre><code>
    FROM ubuntu
    RUN apt-get update && apt-get install tree
</pre></code>

##Terminal

A maquina ubuntu é criada com o nome hello_docker_word, após a execução o cache é removido.

<pre><code>
    sudo su
    docker build -t hello_docker_word .
    docker run -it --rm hello_docker_word
</pre></code>

#CENÁRIO 2

##Dockerfile

Mesma maquina é criada porem com a mensagem "HELLO, you are now running a containe" printada no terminal

<pre><code>
    FROM ubuntu
    RUN apt-get update
    CMD echo "HELLO, you are now running a container"; ls
</pre></code>

##Terminal

Sem o -it ele não entra no shell do container

<pre><code>
    sudo su
    docker build -t docker_cmd .
    docker run --rm docker_cmd
</pre></code>

#CENÁRIO 3

##Dockerfile

Crio uma máquina com uma cópia somente leitura de todos os arquivos da pasta copy_folder

<pre><code>
    FROM ubuntu
    RUN apt-get update
    COPY ./copy_folder /root/copy_folder
</pre></code>

##Terminal

Docker images exibe todas as imagens da maquina em um dado momento

<pre><code>
    sudo su
    docker build -t docker_copy .
    docker images    
    docker run -it --rm docker_copy
</pre></code>

#CENÁRIO 4

##Dockerfile

Extraio o zip no root com o comando ADD, por default apenas .tar.gz com .zip não funciona

<pre><code>
    FROM ubuntu
    RUN apt-get update && apt-get install nano
    ADD ./copy_folder.tar.gz /root/
    CMD if test -d "/root/copy_folder"; then echo "The folder has been extracted"; fi
</pre></code>

##Terminal

Executo o container e abro o arquivo 'a' no nano

<pre><code>
    sudo su
    docker build -t docker_zip .
    docker run -it --rm docker_zip nano /root/copy_folder/a
</pre></code>

