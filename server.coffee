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
bodyParser = require "body-parser"
methodOverride = require "method-override"
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
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: true)
app.use methodOverride((req) ->
  if req.body and typeof req.body == 'object' and '_method' of req.body
    # look in urlencoded POST bodies and delete it
    method = req.body._method
    delete req.body._method
    return method
  return
)

app.use flash()    
app.use passport.initialize()
app.use passport.session()
require('./config/passport.coffee') passport


app.set 'view engine', 'pug'



# http://expressjs.com/en/starter/basic-routing.html
app.get "/", (request, response) -> 
  if request.isAuthenticated()
    response.render 'index', title: 'Hey'
  else
    response.render 'login'


app.post '/login', passport.authenticate('local-login',
  successRedirect: '/'
  failureRedirect: '/login'
  failureFlash: true)

app.get '/login', (req, res) -> 
  res.render 'login'

app.get '/signup', (req, res) -> 
  res.render 'signup'
  

app.post '/signup', passport.authenticate('local-signup',
  successRedirect: '/login'
  failureRedirect: '/signup'
  failureFlash: true)
                          
isLoggedIn = (req, res, next) ->
  # if user is authenticated in the session, carry on
  if req.isAuthenticated()
    return next()
  # if they aren't redirect them to the home page
  res.redirect '/login'
  return



listener = app.listen process.env.PORT, () -> 
  console.log "Your app is listening on port"

