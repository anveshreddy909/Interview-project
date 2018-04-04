mongoose = require 'mongoose'
bcrypt = require "bcrypt"
Schema = mongoose.Schema

searchSchema = mongoose.Schema(
  user: { type : Schema.ObjectId, ref : 'User' },
  searchQuery: String,
  name: String
)

# methods ======================
# generating a hash


# create the model for users and expose it to our app
module.exports = mongoose.model('Search', searchSchema)

# ---