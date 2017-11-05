ReadLine = require('linebyline')
Stats = require("stats-array")

ip_match = '/\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'
two_hundred = /\s2\d\d\s\d/
three_hundred = /\s3\d\d\s\d/
four_hundred = /\s4\d\d\s\d/

readLine = ReadLine('./my.log')

success = 0
redirect = 0
failure = 0
fail_uri = null
failure_code = null
ip_addresses = []
res_sizes = []

readLine.on 'line', (line) ->
  res_sizes.push(line.match(/\b(\d*)\b\s"/)[0].slice(0, -2))
  success++ if line.match(two_hundred) != null
  redirect++ if line.match(three_hundred) != null
  if line.match(four_hundred) != null
    failure++
    fail_uri = line.match(/"(.*?)"/)[0]
    failure_code = line.match(four_hundred)[0].slice(0, -2)
    console.log fail_uri

readLine.on 'end', ->
  console.log "Success Codes: #{success}"
  console.log "Redirect Codes: #{redirect}"
  console.log "Failure Codes: #{failure}"
  console.log "Largest resource size in bytes: #{res_sizes.max()}"
  console.log "Average resource size in bytes: #{res_sizes.mean()}"
  console.log "Smallest resource size in bytes: #{res_sizes.min()}"
  console.log "Failure URI: #{fail_uri} - #{failure_code.trim()}"
