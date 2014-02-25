(function() {
$(function() {

    var queryString, queryData;
  $('#search-button').click(function(e) {
    e.preventDefault();
    queryString = $("#search-form").val();
    queryData = { address : queryString };
    $.ajax({
      url: '/meetings/search',
      type: 'GET',
      dataType: 'json',
      data: queryData,
      success: function(response) {
        console.log('hehehehehe')
        // clearMarkers();
        // for (var meeting in response) {
        //   console.log(response[meeting]);
        //   addToMap(response[meeting]);
        // }
      },
      error: function(response) {
        var errors = response.responseJSON;
        if(errors) {
          $('#flash-section').html(errors);
        }
      }
    }).done(function(response) {
      addResults(response, queryString);
    });
  });

});

var addResults = function(response, queryString) {
  $('#search-results').html('');
  if (response.length === 0) {
    $('#search-results').append("Sorry, no meetings matched your search.");
  } else {
    for (var meeting in response) {
      var meetingName = '<h3>' + response[meeting]["name"] + '</h3>';
      var mapLink = '<a class="view-map-link" href="#">view map</a>'
      var meetingLocation = '<p>Location: ' + response[meeting]["location"] + '</p>';
      var meetingAddress = '<p>Address: ' + response[meeting]["address"] + '</p>';
      var meetingDay = '<p>Day: ' + response[meeting]["day"] + '</p>';
      var meetingTime = '<p>Time: ' + response[meeting]["time"] + '</p>';
      var meetingData = '<h3>Meetings for <em>' + queryString + '</em></h3><div class="individual-search-result col-lg-12">' + meetingName + mapLink + meetingLocation + meetingAddress + meetingDay + meetingTime + '</div>'
      $('#search-results').append(meetingData);
    };
  };
};


var markers = [];

var addToMap = function(meeting) {
  var marker = L.mapbox.markerLayer({
    // this feature is in the GeoJSON format: see geojson.org
    // for the full specification
    type: 'Feature',
    geometry: {
        type: 'Point',
        // coordinates here are in longitude, latitude order because
        // x, y is the standard for GeoJSON and many formats
        coordinates: [parseFloat(meeting["lng"]), parseFloat(meeting["lat"])]
    },
    properties: {
        title: meeting["name"],
        description: meeting["address"],
        // one can customize markers by adding simplestyle properties
        // http://mapbox.com/developers/simplestyle/
        'marker-size': 'large',
        'marker-color': '#f0a'
        // 'marker-symbol': counter
    }
  });
  markers.push(marker);
  marker.addTo(map);
  // setTimeout(function() {

  //     // wait 1 second before announcing the result
  //   }, 1000);
    console.log(markers);
};


var clearMarkers = function() {
  for (var m in markers) {
    markers[m].clearLayers();
  }
};
})();
