

$(document).ready(function () {
  console.log(services);
  $('#searchField').keyup(function(event){
    this.value.length>2?services.getDomainSuggestion(this.value)
          .then(data=>{
            console.log(data);
            (data.data || []).forEach(val=>{
              $('#search-results').append('<li class="list-group-item" value='+val.domain+'>'+val.name+'</li>')
            });
            $('#search-results').toggle();
          }): null;
  });
  
   $('#search-results').click(event=>{
     console.log(event);
   });
  
})