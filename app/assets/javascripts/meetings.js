$(function() {

  $('#search-button').click(function(e) {
    var queryString, queryData;
    e.preventDefault();
    queryString = $("#search-form").val();
    queryData = { zipcode : queryString };
    $.ajax({
      url: '/meetings/search',
      type: 'GET',
      dataType: 'json',
      data: queryData,
      success: function(response) {
        // clearMarkers();
        // var counter = 1;
        // for (var store in response) {
        //   addToMap(response[store], counter);
        //   counter++;
        // }
        console.log(response)
      },
      error: function(response) {
        var errors = response.responseJSON;
        if(errors) {
          $('#flash-section').html(errors);
        }
      }
    })
  });

});
