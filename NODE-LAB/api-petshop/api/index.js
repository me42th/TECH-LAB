const express = require('express')
const bodyParser = require('body-parser')
const config = require('config')
const app = express()

app.use(bodyParser.json())

app.listen(3000, () => console.log(config))