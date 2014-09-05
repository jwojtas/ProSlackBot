# Description:
#   An alternate to the existing beer script, this will scrape beer advocate for the most recent accessed beer.
#   It returns the name of the beer, a picture of the beer and a link to the beer. Hubot is now full of
#   different options for beer scripts. Removing the ? (optional) after (a|advocate) will force the command
#   to be 'beer advocate me' and thereby allow this script to coexist with other beer scripts peacefully.
#
# Dependencies:
#   "cheerio": "0.7.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot advocate beer - returns the latest beer discussed on beer advocate with picture
#
# Author:
#   zgross

cheerio = require('cheerio')

module.exports = (robot) ->
  robot.respond /(a|advocate) beer?/i, (msg) ->
    msg.send "I hear you but it isn't time for beer yet"
    #url = "http://www.beeradvocate.com/beer"
    #msg.http(url)
    #   .get() (err, res, body) ->
    #      if (err)
    #        msg.send "There was an error contacting beeradvocate.com"
    #        return
    #      msg.send "#{getBeerName body} | brewed by: #{getBrewery body} style: #{getBeerStyle body} #{getBeerABV body}"

getBeerABV = (body, callback) ->
  $ = cheerio.load(body)
  $('div#rating_fullview_content_3:first').text().match(/\d+\.\d+/)[0] + " ABV"

getBeerName = (body, callback) ->
  $ = cheerio.load(body)
  $('div#rating_fullview_content_3 h6:first').text()

getBeerStyle = (body, callback) ->
  $ = cheerio.load(body)
  $($('div#rating_fullview_content_3:first > a')[1]).text()

getBrewery = (body, callback) ->
  $ = cheerio.load(body)
  $('div#rating_fullview_content_3:first > a:first').text()

