require './spec_helper'
fs = require 'fs'
parse = require('../lib/request_parser').parse

describe 'lib/request_parser', ->
  describe "#parse", ->
    it "parses fixtures/request.txt", ->
      request = fs.readFileSync('test/fixtures/request.txt').toString()
      parse(request).should.eql {
        server: 'localhost'
        headers: [
          "GET /bla"
          "HTTP/1.1 200 OK"
          "Server: Apache-Coyote/1.1"
          "Content-Type: application/json"
          ""
          "2000"]
        body:
          status: 'success'
          query: null
          bla: 0.0
          more_bla: 12.3
          and_more_bla: 12.6
          description: 'OK'
      }

