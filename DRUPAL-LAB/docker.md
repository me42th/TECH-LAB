> DRUPAL
```
docker pull drupal

docker run -d --name some-mysql --network some-network \
    -e MYSQL_DATABASE=drupal \
    -e MYSQL_USER=user \
    -e MYSQL_PASSWORD=password \
    -e MYSQL_ROOT_PASSWORD=password \
mysql:5.7
```

> MYSQL
```
docker pull mysql

docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag

docker run -it --rm mysql mysql -hsome.mysql.host -usome-mysql-user -p
```