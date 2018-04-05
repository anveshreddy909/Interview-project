mongoose = require('mongoose');
User = require '../models/user.coffee'

###
#create new search item
###
exports.signup = (req, res) -> 
  res.render 'signup'

exports.logout = (req, res) ->
    req.logout()
    res.redirect '/' ;
    
exports.login = (req, res) ->
    req.render 'login'