# BUGS 

## /usr/bin/env: “node”: Arquivo ou diretório não encontrado

- sudo update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

## ERR: Your Node.js version is v4.2.6. Please update to the latest Node LTS version.

#### Solution 1
- sudo apt-get purge --auto-remove nodejs
- sudo npm cache clean -f
- sudo npm install -g n
- sudo n stable

#### Solution 2
- [NVM](https://medium.com/collabcode/como-instalar-node-js-no-linux-corretamente-ubuntu-debian-elementary-os-729fb4c92f2d)

- nvm use node

## Error: Cannot find module '@angular/compiler-cli

- rm -r node_modules
- npm cache clean --force
- npm install

## Unhandled rejection Error: EACCES: permission denied, mkdir '/home/davidmeth/.npm/[...]'

- chmod -R 777 .

## Ionic livereload doesnt work

> on linux solved by putting in /etc/sysctl.conf

- fs.inotify.max_user_watches=524288

> then reboot or

- sudo sysctl --system

# INSTALL

- **npm install -g ionic**
- **ionic start myApp super --type=ionic-angular**
- **ionic serve**

# VISUAL STUDIO EXTENSIONS

- **browser preview**
- **angular essentials**
- **material icons theme**