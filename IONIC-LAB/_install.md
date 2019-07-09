# BUGS 

## /usr/bin/env: “node”: Arquivo ou diretório não encontrado

- sudo update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

## ERR: Your Node.js version is v4.2.6. Please update to the latest Node LTS version.

- sudo npm cache clean -f
- sudo npm install -g n
- sudo n stable

## Error: Cannot find module '@angular/compiler-cli

- rm -r node_modules
- npm cache clean --force
- npm install

# INSTALL

- ionic start myApp tabs
- cd myApp
- ionic serve