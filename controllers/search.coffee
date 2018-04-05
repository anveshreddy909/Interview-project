mongoose = require('mongoose');
SearchModel = require '../models/search.coffee'

###
#create new search item
###
exports.create = (req, res) -> 
    newSearch = new SearchModel
    newSearch.user = req.user
    newSearch.searchQuery = req.body.value
    newSearch.labels = req.body.label
    newSearch.name = req.body.name
    newSearch.save (err) ->
          if err
            return err
          return res.json status: "success"
        
###
#loads list of saved searches
###
exports.loadSaveSearch = (req, res) ->
    SearchModel.find {user: req.user._id}, {_id: 0, user: 0, __v: 0},  (err, searchResults)  ->
      if err
            return err
      return res.json {data: searchResults, status: "success"}
    
exports.index = (req, res) ->
  if req.isAuthenticated()
    res.render 'search'
  else
    res.render 'login'