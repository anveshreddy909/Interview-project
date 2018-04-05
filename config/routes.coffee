search = require "../controllers/search.coffee"

module.exports = (app, passport) ->
    
    app.post '/savesearch', search.create
    app.get '/loadsavesearch', search.loadSaveSearch
    app.get "/search", search.index