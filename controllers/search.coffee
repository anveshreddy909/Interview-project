const mongoose = require('mongoose');
SearchModel = require '../models/search.coffee'


export.create = (req, res) -> 
    newSearch = new SearchModel
    newSearch.user = req.user
    newSearch.searchQuery = req.body.value
    newSearch.labels = req.body.label
    newSearch.name = req.body.name
    newSearch.save (err) ->
          if err
            return err
          return res.json status: "success"