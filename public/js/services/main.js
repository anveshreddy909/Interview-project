const services = {
  
  getDomainSuggestion: function(input) {
    return fetch('https://hunter.io/v2/domains-suggestion?query='+input)
          .then(response=>response.json())
          .catch(e=>Promise.reject("domains call failed"))
          .then(response=>Promise.resolve(response))
  },
  
  saveSearch: function(searchVal, searchname) {
    return fetch('/savesearch?searchParams='+searchVal+'&name='+searchname, {credentials:'include'})
          .then(response=>response.json())
          .catch(e=>Promise.reject("save call failed"))
          .then(response=>Promise.resolve(response))
  },
  
  loadSaveSearch: function() {
    return fetch('/loadsavesearch', {credentials:'include'})
          .then(response=>response.json())
          .catch(e=>Promise.reject("load call failed"))
          .then(response=>Promise.resolve(response))
  },
  
  search: function(domain) {
    return fetch(`https://api.hunter.io/v2/email-count?domain=${domain}`,headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }) 
          .then(response=>response.json())
          .catch(e=>Promise.reject("search call failed"))
          .then(response=>{
              return Promise.resolve(response)
          })
  }
  
}