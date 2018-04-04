export default {
  
  getDomainSuggestion: function(input) {
    return fetch('https://hunter.io/v2/domains-suggestion?query='+input)
           .then()
  }
  
}