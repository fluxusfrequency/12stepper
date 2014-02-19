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
      },
      error: function(response) {
        var errors = response.responseJSON;
        if(errors) {
          $('#flash-section').html(errors);
        }
      }
    }).done(function(response) {
      addResults(response);
    });
  });

});

var addResults = function(response) {
  $('#search-results').html('');
  if (response.length === 0) {
    $('#search-results').append("Sorry, no meetings matched your search.");
  } else {
    for (var meeting in response) {
      var meetingName = '<h3>' + response[meeting]["name"] + '</h3>'
      var meetingLocation = response[meeting]["location"] + '<br/>'
      var meetingAddress = response[meeting]["address"] + '<br/>'
      var meetingDay = response[meeting]["day"] + '<br/>'
      var meetingTime = response[meeting]["time"] + '<br/>'
      var meetingFellowship = response[meeting]["fellowship"] + '<br/>'
      $('#search-results').append(meetingName + meetingLocation + meetingAddress + meetingDay + meetingTime + meetingFellowship);
    };
  };
};
