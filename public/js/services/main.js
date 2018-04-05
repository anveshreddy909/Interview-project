const services = {
  
  getDomainSuggestion: function(input) {
    return fetch('https://hunter.io/v2/domains-suggestion?query='+input)
          .then(response=>response.json())
          .catch(e=>Promise.reject("domains call failed"))
          .then(response=>Promise.resolve(response))
  },
  
  saveSearch: function(searchVal, searchname, labelItem) {
    const saveData= {
      value: searchVal,
      name: searchname,
      label: labelItem
    }
    return fetch('/savesearch', {credentials:'include', method: 'POST', body: JSON.stringify(saveData), headers: {'content-type': 'application/json'}})
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
    return fetch('/searchDomain?domain='+domain,{credentials:'include'}) 
          .then(response=>{console.log("response data",response);return response.json()})
          .then(data=>{console.log("data data",data); return Promise.resolve(data)})
          .catch(e=>Promise.reject("search call failed"))
          
  }
  
}