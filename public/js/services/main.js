const services = {
  
  getDomainSuggestion: function(input) {
    return fetch('https://hunter.io/v2/domains-suggestion?query='+input)
          .then(response=>response.json())
          .catch(e=>Promise.reject("domains call failed"))
          .then(response=>Promise.resolve(response))
  },
  
  saveSearch: function(searchVal, searchname) {
    return fetch('/savesearch?searchParams='+searchVal+'&name='+searchname)
          .then(response=>response.json())
          .catch(e=>Promise.reject("cities call failed"))
          .then(response=>Promise.resolve(response))
  }
  
}