ReadLine = require('linebyline')

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
  success++ if line.match(two_hundred) != null
  redirect++ if line.match(three_hundred) != null
  if line.match(four_hundred) != null
    failure++
    fail_uri = line.match(/"(.*?)"/)
  console.log(fail_uri)
