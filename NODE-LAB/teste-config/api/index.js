const config = require('config');
const express = require('express');
const app = express();

app.listen('3000',() => console.log(config.get('estou')));