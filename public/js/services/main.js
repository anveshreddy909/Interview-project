const services = {
  
  getDomainSuggestion: function(input) {
    return fetch('https://hunter.io/v2/domains-suggestion?query='+input)
          .then(response=>response.json())
          .catch(e=>Promise.reject("cities call failed"))
          .then(response=>Promise.resolve(response))
  }
  
}