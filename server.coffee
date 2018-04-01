// server.js
// where your node app starts

// init project
express = require "express"
app = express()

// we've started you off with Express, 
// but feel free to use whatever libs or frameworks you'd like through `package.json`.

// http://expressjs.com/en/starter/static-files.html
app.use(express.static('public'))

app.set('view engine', 'pug')

// http://expressjs.com/en/starter/basic-routing.html
app.get("/", (request, response) => {
  //response.sendFile(__dirname + '/views/index.html')
  response.render('login', { title: 'Hey', message: 'Hello there!' })
})

// Simple in-memory store
dreams = [
  "Find and count some sheep",
  "Climb a really tall mountain",
  "Wash the dishes"
  
]

app.get("/dreams", (request, response) => {
  response.send(dreams)
})

// could also use the POST body instead of query string: http://expressjs.com/en/api.html#req.body
app.post("/dreams", (request, response) => {
  dreams.push(request.query.dream)
  response.sendStatus(200)
})

// listen for requests :)
listener = app.listen(process.env.PORT, () => {
  console.log(`Your app is listening on port ${listener.address().port}`)
})
