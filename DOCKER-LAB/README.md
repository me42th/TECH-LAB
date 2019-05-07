# CENÁRIO 1

##  Dockerfile

Um container ubuntu atualizado e com o tree instalado

<pre><code>
    FROM ubuntu
    RUN apt-get update && apt-get install tree
</pre></code>

##  Terminal

A maquina ubuntu é criada com o nome hello_docker_word, após a execução o cache é removido.

<pre><code>
    sudo su
    docker build -t hello_docker_word .
    docker run -it --rm hello_docker_word
</pre></code>

# CENÁRIO 2

##  Dockerfile

Mesma maquina é criada porem com a mensagem "HELLO, you are now running a containe" printada no terminal

<pre><code>
    FROM ubuntu
    RUN apt-get update
    CMD echo "HELLO, you are now running a container"; ls
</pre></code>

##  Terminal

Sem o -it ele não entra no shell do container

<pre><code>
    sudo su
    docker build -t docker_cmd .
    docker run --rm docker_cmd
</pre></code>

# CENÁRIO 3

##  Dockerfile

Crio uma máquina com uma cópia somente leitura de todos os arquivos da pasta copy_folder

<pre><code>
    FROM ubuntu
    RUN apt-get update
    COPY ./copy_folder /root/copy_folder
</pre></code>

##  Terminal

Docker images exibe todas as imagens da maquina em um dado momento

<pre><code>
    sudo su
    docker build -t docker_copy .
    docker images    
    docker run -it --rm docker_copy
</pre></code>

# CENÁRIO 4

##  Dockerfile

Extraio o zip no root com o comando ADD, por default apenas .tar.gz com .zip não funciona

<pre><code>
    FROM ubuntu
    RUN apt-get update && apt-get install nano
    ADD ./copy_folder.tar.gz /root/
    CMD if test -d "/root/copy_folder"; then echo "The folder has been extracted"; fi
</pre></code>

##  Terminal

Executo o container e abro o arquivo 'a' no nano

<pre><code>
    sudo su
    docker build -t docker_zip .
    docker run -it --rm docker_zip nano /root/copy_folder/a
</pre></code>

# CENÁRIO 5

##  Dockerfile

Seto a pasta root como a pasta de trabalho e as alterações serão feitas nesta pasta

<pre><code>
    FROM ubuntu
    WORKDIR /root/

    RUN touch ./test.txt
    RUN touch ./test_2.txt
    RUN touch ./test_3.txt

    RUN mkdir -p ./testfolder
    WORKDIR /root/testfolder

    RUN mkdir -p ./child
    RUN mkdir -p ./child_1    
    
</pre></code>

##  Terminal

Executo o container e abro o arquivo 'a' no nano

<pre><code>
    sudo su
    docker build -t docker_zip .
    docker run -it --rm docker_zip nano /root/copy_folder/a
</pre></code>


# CENÁRIO 6

##  Dockerfile

Determino a execução de um comando por default ao instanciar um conteiner. Há diferenças entre invocar um comando com CMD e com ENTRYPOINT;
O PRIMEIRO NÃO SERÁ EXECUTADO CASO AJA UM ARGUMENTO NA FUNCTION DO SHELL, O SEGUNDO É EXECUTADO OBRIGATORIAMENTE 

<pre><code>
    FROM ubuntu
    RUN apt-get update
    # ENTRYPOINT ls
    CMD ls
</pre></code>

##  Terminal

Primeiro o entrypoint é executado e somente após é executada a instrução passada como argumento

<pre><code>
    sudo su
    docker build -t docker_entrypoint
    docker run --rm docker_entrypoint pwd; cd root; ls
</pre></code>

# CENÁRIO 7

##  Dockerfile

Declaro uma variável de ambiente e uso a mesma para seta a opção WORKDIR

<pre><code>
    FROM  ubuntu
    RUN apt-get update
    ENV workdir=/root/
    WORKDIR $workdir
</pre></code>

##  Terminal

<pre><code>
    sudo su
    docker build -t docker_env
    docker run -it --rm docker_env    
</pre></code>

# CENÁRIO 8

##  Dockerfile

<pre><code>
</pre></code>

##  Terminal

<pre><code>
</pre></code>

# CENÁRIO NULL

##  Dockerfile

<pre><code>
</pre></code>

##  Terminal

<pre><code>
</pre></code>
