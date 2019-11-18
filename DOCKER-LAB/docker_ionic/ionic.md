# [RUN IONIC FRAMEWORK WITH DOCKER](https://hub.docker.com/r/agileek/ionic-framework/)

**SHELL**
```
docker pull agileek/ionic-framework

docker run -ti --rm -p 8100:8100 -p 35729:35729 agileek/ionic-framework

docker run -ti --rm -p 8100:8100 -p 35729:35729 -v C:\Users\david.meth\Documents\tech-lab\IONIC-LAB\forms_of_metal:/myApp:rw agileek/ionic-framework:1.4.5
```