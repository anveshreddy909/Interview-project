

$(document).ready(function () {
  console.log(services);
  let tokenFieldObj = {
    autocomplete: {
      source: ['red'],
      delay: 100
    },
    showAutocompleteOnFocus: false
  }
  $('#searchField').tokenfield(tokenFieldObj);
  $('#searchField').keypress(event=>{
    console.log(event.value)
  });
})