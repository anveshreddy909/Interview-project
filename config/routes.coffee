
module.exports = (app, passport) ->

  # http://expressjs.com/en/starter/basic-routing.html
  app.get "/", (request, response) -> 
    if request.isAuthenticated()
      response.render 'index', title: 'Hey'
    else
      response.render 'login'

  app.get "/search",  (request, response) -> 
    if request.isAuthenticated()
      response.render 'search', title: 'Hey'
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

  app.get '/savesearch',isLoggedIn, (request, response) ->
      console.log request.query.searchParams
      newSearch = new SearchModel
      newSearch.user = request.user
      newSearch.searchQuery = request.query.searchParams
      newSearch.name = request.query.name
      newSearch.save (err) ->
            if err
              return err
            return response.json status: "success"

  app.get '/loadsavesearch',isLoggedIn, (req, res) ->
    console.log req.user


isLoggedIn = (req, res, next) ->
  console.log req, res ,next
  # if user is authenticated in the session, carry on
  if req.isAuthenticated()
    return next()
  # if they aren't redirect them to the home page
  res.redirect '/login'
  return
