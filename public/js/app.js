

$(document).ready(function () {
  console.log(services);
  const searchItem = [];
  $('#searchField').keyup(function(event){
    this.value.length>2?services.getDomainSuggestion(this.value)
          .then(data=>{
            console.log(data);
            $('#search-results').html();
            (data.data || []).forEach(val=>{
              $('#search-results').append('<li class="list-group-item" value='+val.domain+'>'+val.name+'</li>')
            });
            $('#search-results').toggle();
          }): null;
  });
  
   $('#search-results').click(event=>{
     console.log($(event.target).attr('value'));
     searchItem.push({value: $(event.target).attr('value'), label: event.target.innerHTML});
     console.log(searchItem);
     $('#search-results').toggle();
     $('.searchVal').html(searchItem.reduce((finalVal, val)=>{return (finalVal? finalVal+ ", "+ val.label : val.label)},""));
     $('#searchField').value="";
   });
  
})