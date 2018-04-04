

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
    services.saveSearch(searchItem.reduce((finalVal, val)=>{return (finalVal? finalVal+ ", "+ val.value : val.value)},""), $('#searchName').val())
            .then(data=>{
              console.log(data);
              if(data.status.toLowerCase() === "success"){
                alert("saved search successfully!");
              }
            })
            .catch(e=>alert("error"))
  });
  
  $('#showSavedItems').click(()=>{
    services.loadSaveSearch();
  });
  
})