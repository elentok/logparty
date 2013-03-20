parseLine = (line) ->
  line = line.substring(3)
  line = eval(line).trim()

exports.parse = (rawRequest) ->
  request =
    server: ''
    headers: []
    body: ''

  state = 'idle'

  addToBody = (line) ->
    if /"$/.test(line)
      line = parseLine(line)
      if line != '"\\r\\n"'
        request.body += line

  rawRequest.split("\n").forEach (line) ->
    serverMatch = /^opening connection to (.*)...$/.exec(line)
    if serverMatch?
      state = 'in-request-head'
      request.server = serverMatch[1]
    else
      unless /^opened/.test(line)
        if state == 'in-request-head'
          if /^(<-|->)/.test(line)
            request.headers.push(parseLine(line))
          else if /^reading/.test(line)
            state = 'in-request-body'
        else if state == 'in-request-body'
          #if /^Conn close/.test(line)
            #break
          if /^read /.test(line)
            state = 'in-request-crap'
          else if /^->/.test(line)
            addToBody(line)
        else if state == 'in-request-crap'
          #if /^Conn close/.test(line)
            #break
          if /^reading/.test(line)
            state = 'in-request-body'

  try
    request.body = JSON.parse(request.body)

  request
