var pkginfo = require('pkginfo')(module, 'version', 'name');
const express = require('express')
const app = express()
const PORT = process.env.PORT | 3000

app.get('/', function (req, res) {
  res.send({output: 'Hello World!'})
})

app.get('/info', function (req, res) {
  res.send({
    name: process.env.NAME | module.exports.name,
    version: process.env.VERSION | module.exports.version
  })
})

app.listen(PORT, function () {
  console.log('Example app (%s, %s) listening on port %s!', module.exports.name, module.exports.version, PORT)
})

module.exports = app
