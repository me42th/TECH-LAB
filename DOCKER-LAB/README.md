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

    Informo metadados com a palavra LABEL

<pre><code>
    FROM ubuntu
    RUN apt-get update
    LABEL Description="This is th Docker Image to showcase the usage of Label Docker Command"
</pre></code>

##  Terminal

<pre><code>
    sudo su
    docker build --label "key"="value" -t docker_label .
    docker run -it --rm docker_label
</pre></code>

# CENÁRIO 9

##  Dockerfile

Healthcheck verifica se está tudo bem com o container 

- Flag **--interval** determina a cada quantos segundos o script deve rodar
- Flag **--timeout** se o comando não ter um retorno no tempo determinado é pq deu ruim
- Flag **--retries** ele irá tentar executar x vezes
- Flag **CMD** aqui este comando atua parcialmente como flag, a instrução que ele invoca é que é responsável pela validação 

<pre><code>
    FROM ubuntu
    RUN apt-get update
    RUN mkdir labels_cd
    HEALTHCHECK --interval=5s --timeout=3s --retries=2 CMD cd ./labels_cd || exit 1
</pre></code>

##  Terminal

- **docker ps -a** ==> exibe os containners e seu histórico e se estão "saudáveis" pelo critério em HEALTHCHECK
- **docker kill [CONTAINER ID]** ==> encerro a execução de um determinado container  
- **docker inspect [CONTAINER NAME]** ==> retorna um json com informações do container

<pre><code>
    sudo su
    docker build -t docker_health .
    docker run -it --rm docker_health
    docker ps -a
    docker inspect docker_health
    docker kill a8d60f3c7a94
</pre></code>

# CENÁRIO 10

##  Dockerfile

Finalizar o docker

<pre><code>
    FROM ubuntu
    RUN apt-get update
    STOPSIGNAL SIGKILL
</pre></code>

##  Terminal

- Flag **--name** a coluna "name" do "docker stats" passa a ser ocupada pelo valor passado 
- Command **docker stop [name container]** finaliza a execução do container indexado pelo name

<pre><code>
    sudo su
    docker build -t stop_signal .
    docker run -it --name stop_signal stop_signal
    docker stop docker_stop
</pre></code>

# CENÁRIO 11

##  Dockerfile

<pre><code>
    FROM ubuntu
    RUN apt-get update
</pre></code>

##  Terminal

- Flag **--name docker_volume_1** nome da instancia
- Flag **-v /data** volume que será persistido
- Flag **rm [conteiner name]** apago um container 
- Flag **--volumes-from docker_vol_1** persisto os dados dos volumes usados no conteiner setado com esse nome

<pre><code>
    docker build -t docker_vol .
    docker run -it --name docker_vol_1 -v /data docker_volume 
    docker run -it --name docker_vol_2 --volumes-from docker_vol_1
    docker rm docker_vol_1
</pre></code>

# CENÁRIO 12

##  Dockerfile

<pre><code>
    FROM ubuntu
    RUN apt-get update && apt-get install nano
</pre></code>

##  Terminal

Alem de persistir os dados edito os mesmos que estão salvos na maquina local 

- Flag **-v "$(pwd)/copy_folder":/folder** onde copy_folder é a pasta no host e folder a pasta no conteiner

<pre><code>
    docker build -t docker_mount .
    docker run -it -v "$(pwd)/copy_folder":/folder docker_mount
</pre></code>


# CENÁRIO 13

##  Dockerfile

- Command **EXPOSE** passa a usar uma porta do hospedeiro, 80 é a porta do container

<pre><code>
    # FROM php:7.2-fpm
    FROM tutum/lamp
    EXPOSE 80
</pre></code>

##  Terminal

- Flag **-p 4242:80** a porta 80 do container poderá ser acessada pela porta 4242 do host

<pre><code>
    sudo su
    docker build -t docker_expose .
    docker run -it --rm -p 4242:80 docker_expose
</pre></code>

# CENÁRIO 14

##  Dockerfile

<pre><code>
    # FROM php:7.2-fpm
    FROM tutum/lamp
    EXPOSE 80
</pre></code>

##  Terminal

    - CMD **network** executa as operação de rede do docker
    - CMD **create** cria coisas de rede
    - CMD **ls** exibe as redes e informações básicas sobre as mesmas
    - FLAG **--subnet 172.28.0.0/16 Bird** cria a subrede Bird com a/b para rede e c/d host    
    - FLAG **--ip 172.28.0.10** atribui o endereço ip 172.28.0.10 ao container
    - FLAG **--net Bird** vincula o container a subrede Bird

<pre><code>
    sudo su
    docker network create --subnet 172.28.0.0/16 Bird
    docker network ls
    docker build -t docker_network .
    docker run -it --name docker_network --ip 172.28.0.10 --net Bird docker_network    
</pre></code>

# CENÁRIO 15

##  Dockerfile

<pre><code>

</pre></code>

##  Terminal

<pre><code>
    sudo su
</pre></code>

# CENÁRIO NULL

##  Dockerfile

<pre><code>
</pre></code>

##  Terminal

<pre><code>
</pre></code>