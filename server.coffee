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
require('./config/passport.coffee') passport


app.set 'view engine', 'pug'



# http://expressjs.com/en/starter/basic-routing.html
app.get "/", (request, response) -> 
  #response.sendFile(__dirname + '/views/index.html')
  response.render 'login', title: 'Hey'

  


app.post '/login', passport.authenticate('local-login',
  successRedirect: '/'
  failureRedirect: '/login'
  failureFlash: true)

app.get '/login', (req, res) -> 
  res.render 'login'

app.get '/signup', (req, res) -> 
  res.render 'signup'
  
app.post '/signup', passport.authenticate 'local-signup', (req, res) -> 
  console.log "passport user", req;
                                         


listener = app.listen process.env.PORT, () -> 
  console.log "Your app is listening on port"

