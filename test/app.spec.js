var app = require('../app');
var chai = require('chai');
var chaiHttp = require('chai-http');
chai.use(chaiHttp);

var expect = chai.expect;
var should = chai.should();

describe('GET /', function() {
  it('should return hello world', function(done) {
    chai.request(app).get('/')
      .end((err, res) => {
        expect(res).to.have.status(200);
        expect(res.body).to.have.property('output')
        expect(res.body.output).to.equal("Hello World");
        done()
      })
  });
});

describe('GET /info', function() {
  it('should return name, version and hostname', function(done) {
    chai.request(app).get('/info')
    .end((err, res) => {
      expect(res).to.have.status(200);
      expect(res.body).to.have.property('versions')
      expect(res.body).to.have.property('name')
      expect(res.body).to.have.property('hostname')
      done()
    })
  })
})

describe('GET /health', function() {
  it('should return status', function(done) {
    chai.request(app).get('/health')
    .end((err, res) => {
      expect(res).to.have.status(200);
      expect(res.body).to.have.property('status')
      expect(res.body.status).to.equal('UP')
      done()
    })
  })
})
