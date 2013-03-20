isRequestComplete = (requestChunk) ->
  /^Conn close$/m.test(requestChunk)

exports.parseChunk = (chunk) ->
  requestChunks = chunk.split(/^opening conn/m)
  after = null

  if requestChunks.length == 0
    {
      requests: []
      after: chunk
    }
  else
    requests = []
    after = null

    unless /^ection/.test(requestChunks[0])
      requestChunks = requestChunks.slice(1)

    lastRequest = requestChunks[requestChunks.length-1]
    unless isRequestComplete(lastRequest)
      after = 'opening conn' + lastRequest
      requestChunks = requestChunks.slice(0, -1)

    requestChunks.forEach (request) ->
      requests.push('opening conn' + request)

    {
      requests: requests
      after: after
    }

