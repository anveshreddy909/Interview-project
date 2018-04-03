# server.js
# where your node app starts
# init project
express = require "express"
app = express()
passport = require "passport"
passportLocal = require "passport-local"
Strategy = passportLocal.Strategy
mongoose = require "mongoose"
db = require "./db.js"
User = require "./models/user.coffee"
expressSession = require "express-session"

myPlaintextPassword = 's0/\/\P4$$w0rD'
saltRounds = 10
flash  = require "connect-flash"
mongoose.connect db.url


# we've started you off with Express, 
# but feel free to use whatever libs or frameworks you'd like through `package.json`.

sessionObj = 
   secret: 'mySecretKey'
        
app.use express.static('public')
app.use expressSession sessionObj
app.use flash()         
app.use passport.initialize()
app.use passport.session()
require('./config/passport') passport


app.set 'view engine', 'pug'



# http://expressjs.com/en/starter/basic-routing.html
app.get "/", (request, response) -> 
  #response.sendFile(__dirname + '/views/index.html')
  response.render 'login', title: 'Hey'

  
passport.serializeUser (user, done) -> 
  done null, user._id
  
passport.deserializeUser (id, done) ->
  user
  
passport.use 'login', new Strategy({ passReqToCallback: true }, (req, username, password, done) ->
  # check in mongo if a user with username exists or not
  User.findOne { 'username': username }, (err, user) ->
    # In case of any error, return using the done method
    if err
      return done(err)
    # Username does not exist, log error & redirect back
    if !user
      console.log 'User Not Found with username ' + username
      return done(null, false, req.flash('message', 'User Not found.'))
    # User exists but wrong password, log the error 
    if !isValidPassword(user, password)
      console.log 'Invalid Password'
      return done(null, false, req.flash('message', 'Invalid Password'))
    # User and password both match, return user from 
    # done method which will be treated like success
    done null, user
  return
)

passport.use 'signup', new Strategy({ passReqToCallback: true }, (req, username, password, done) ->
  
  console.log 'username'+ username
  findOrCreateUser = ->
    # find a user in Mongo with provided username
    
    User.findOne { 'username': username }, (err, user) ->
      # In case of any error return
      console.log 'username'+ username
      if err
        console.log 'Error in SignUp: ' + err
        return done(err)
      # already exists
      if user
        console.log 'User already exists'
        return done(null, false, req.flash('message', 'User Already Exists'))
      else
        # if there is no user with that email
        # create the user
        newUser = new User
        # set the user's local credentials
        newUser.username = username
        newUser.password = createHash(password)
        newUser.email = req.param('email')
        # save the user
        newUser.save (err) ->
          if err
            console.log 'Error in Saving user: ' + err
            throw err
          console.log 'User Registration succesful'
          done null, newUser
      return
    return

  # Delay the execution of findOrCreateUser and execute 
  # the method in the next tick of the event loop
  process.nextTick findOrCreateUser
  return
)


app.post '/login', passport.authenticate('local-login',
  successRedirect: '/'
  failureRedirect: '/login'
  failureFlash: true)

app.get '/login', (req, res) -> 
  res.render 'login'

app.get '/signup', (req, res) -> 
  res.render 'signup'
  
app.post '/signup', (req, res, next) -> 
  passport.authenticate('local-signup',
  successRedirect: '/login'
  failureRedirect: '/'
  failureFlash: true)(req, res, next)
                                         


listener = app.listen process.env.PORT, () -> 
  console.log "Your app is listening on port"

