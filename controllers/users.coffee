mongoose = require('mongoose');
User = require '../models/users.coffee'

###
#create new search item
###
exports.signup = (req, res) -> 
  res.render 'signup'

exports.logout = (req, res) ->
    req.logout()
    res.redirect '/' ;