

$(document).ready(function () {
  console.log(services);
  const searchItem = [];
  $('#searchField').keyup(function(event){
    searchItem.length == 3 ? alert("max search limit reached!"): null;
      
    this.value.length>2?services.getDomainSuggestion(this.value)
          .then(data=>{
            console.log(data);
            $('#search-results').html("");
            (data.data || []).forEach(val=>{
              $('#search-results').append('<li class="list-group-item" value='+val.domain+'>'+val.name+'</li>')
            });
            $('#search-results').show();
          }): $('#search-results').hide();
  });
  
   $('#search-results').click(event=>{
     console.log($(event.target).attr('value'));
     searchItem.push({value: $(event.target).attr('value'), label: event.target.innerHTML});
     console.log(searchItem);
     $('#search-results').hide();
     $('.searchVal').html(searchItem.reduce((finalVal, val)=>{return (finalVal? finalVal+ ", "+ val.label : val.label)},""));
     $('#searchField').val("");
     $('#searchField').attr('placeholder', "");
   });
  
  $('#savesearch').click(()=>{
    if(!$('#searchName').val().length){
      alert("search name cannot be empty");
      return;
    }
    services.saveSearch(searchItem.reduce((finalVal, val)=>{return (finalVal? finalVal+ ", "+ val.value : val.value)},""), $('#searchName').val(), searchItem.reduce((finalVal, val)=>{return (finalVal? finalVal+ ", "+ val.label : val.label)},""))
            .then(data=>{
              console.log(data);
              if(data.status.toLowerCase() === "success"){
                alert("saved search successfully!");
              }
            })
            .catch(e=>alert("error"))
  });
  
  var loadSearchData = function(query, name){
    console.log("load called", query);
  }
  
  var searchDomain = function() {
    let searchArr= [];
    if(searchItem.length) {
      //services.search(searchItem[0].value).then(data=>{console.log(data)})
      searchItem.forEach(val=>{
        searchArr.push(services.search(val.value))
      })
    }
    
    Promise.all([...searchArr])
           .then(data=>{
              console.log("search data",data);
              let searchTable = $('.search-result-table');
              searchTable.append(`<table class="table m-5 table-bordered">
                    <thead class="thead-dark">
                      <tr>
                        <th scope="col">Domain</th>
                        <th scope="col">total email</th>
                        <th scope="col">Generic email</th>
                        <th scope="col">Personal email</th>
                      </tr>
                    </thead>
                    <tbody></tbody>
                </table>`)
             let tableBody = $('.search-result-table tbody');
              data.forEach(val=>{
                tableBody.append(`<tr>
                    <td>${val.data.meta.params.domain}</td>
                    <td>${val.data.data.total}</td>
                    <td>${val.data.data.generic_emails}</td>
                    <td>${val.data.data.personal_emails}</td>
                </tr>`)
              })
      
           })
           .catch(e=>console.log("domain search failed", e));
  }
  
  var clearSearch = function() {
    $('.search-result-table').html("");
    searchItem=[];
    $('#searchField').attr('placeholder', 'Enter search domain ...');
    $('.searchVal').html('');
  }
  
  $('#showSavedItems').click(()=>{
    services.loadSaveSearch()
            .then(data=>{
              data.data.forEach((val, index)=>{
                $('#show-save-results tbody').append(
                  `<tr>
                    <th scope="row">${index}</th>
                    <td>${val.name}</td>
                    <td>${val.searchQuery}</td>
                    <td><button class="btn btn-outline-dark load-btn" query=${val.searchQuery} name=${val.name} >Load</button></td>
                  </tr>`
                )
              });
      
               $('#show-save-results').show(); //
            })
            .catch(e=>console.log(e))
  });
  
  //$('.load-btn').click(function(){console.log("caleed", arguments)});
  $(document).on('click', '.load-btn', loadSearchData);
  
  $('.domain-search ').click(searchDomain);
  $('.search-clear ').click(clearSearch);
})