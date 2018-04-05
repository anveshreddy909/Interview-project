search = require "../controllers/search.coffee"
user = require "../controllers/users.coffee"

module.exports = (app, passport) ->
    
    app.post '/savesearch', search.create
    app.get '/loadsavesearch', search.loadSaveSearch
    app.get '/search', search.index
    app.get '/searchDomain', search.searchDomain
    app.get '/login', user.login
    app.get '/signup', user.signup
    app.get '/logout', user.logout
    
    app.post '/login', passport.authenticate('local-login',
      successRedirect: '/'
      failureRedirect: '/login'
      failureFlash: true)
    
    app.post '/signup', passport.authenticate('local-signup',
      successRedirect: '/login'
      failureRedirect: '/signup'
      failureFlash: true)
    
    app.get "/", (request, response) -> 
      if request.isAuthenticated()
        response.render 'index'
      else
        response.render 'login'
    

    
      