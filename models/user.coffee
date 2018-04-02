mongoose = require 'mongoose'
model = 
  username: String,
  password: String,
  email: String,
  gender: String,
  address: String

module.exports = mongoose.model 'User', model 