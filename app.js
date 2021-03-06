const os = require('os')
//var pkginfo = require('pkginfo')(module);
const express = require('express')
const app = express()
const PORT = process.env.PORT | 3000
const hostname = os.hostname()

app.get('/', function (req, res) {
  res.send({output: 'Hello World'})
})

app.get('/info', function (req, res) {
  res.send({
    name:  module.exports.name || '',
    version: module.exports.version || '',
    hostname: hostname
  })
})

app.get('/health', function (req, res) {
  res.send({
    status: "UP"
  })
})

app.listen(PORT, function () {
  console.log('Express demo app (%s:%s, %s)!', module.exports.name, PORT, module.exports.version)
})

if (process.argv.includes('**/*.spec.js')) {
  module.exports = app
}
