mongoose = require 'mongoose'
bcrypt = require "bcrypt"

userSchema = mongoose.Schema(
  username: String
  email: String,
  password: String)

# methods ======================
# generating a hash

userSchema.methods.generateHash = (password) ->
  bcrypt.hashSync password, bcrypt.genSaltSync(8), null

# checking if password is valid

userSchema.methods.validPassword = (password) =>
  bcrypt.compareSync bcrypt.genSaltSync(8), password, null

# create the model for users and expose it to our app
module.exports = mongoose.model('User', userSchema)

# ---