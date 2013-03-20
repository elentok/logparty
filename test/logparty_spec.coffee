require './spec_helper'
fs = require 'fs'
logparty = require '../lib/logparty'

describe 'lib/logparty', ->
  describe "#parseChunk", ->
    it "parses fixtures/complete_chunk.txt", ->
      chunk = fs.readFileSync('test/fixtures/complete_chunk.txt').toString()
      logparty.parseChunk(chunk).should.eql {
        requests: [
          'opening connection to localhost...\nopened\n<- "GET /one"\nConn close\n',
          'opening connection to localhost...\nopened\n<- "GET /two"\nConn close\n']
        after: 'opening connection to localhost...\nopened\n<- "AFTER"\n'
      }
