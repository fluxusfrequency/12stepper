(function() {
  var meetingDetails = {};
  var searchAddress = {};
  $(function() {

    var queryString, queryData, meetingObject;
    $('#search-button').click(function(e) {
      e.preventDefault();
      queryString = $("#search-form").val();
      queryData = { address : queryString };
      clearMarkers()
      $.ajax({
        url: '/meetings/search',
        type: 'GET',
        dataType: 'json',
        data: queryData,
        success: function(response) {
          addResults(response, queryString);
          mapLinks();
          $.ajax({
            url: 'https://maps.googleapis.com/maps/api/geocode/json?address=' + queryString + '&sensor=false',
            type: 'GET',
            dataType: 'json',
            data: '',
            success: function(response) {
              searchAddress["address"] = queryString;
              searchAddress["lat"] = response["results"][0]["geometry"]["location"]["lat"];
              searchAddress["lng"] = response["results"][0]["geometry"]["location"]["lng"];

            },
            error: function(response) {
              var errors = response.responseJSON;
              if(errors) {
                $('#flash-section').html(errors);
              }
            }
          })

        },
        error: function(response) {
          var errors = response.responseJSON;
          if(errors) {
            $('#flash-section').html(errors);
          }
        }
      }).done(function(response) {
      });
    });

  });

  var addResults = function(response, queryString) {
    $('#search-results').html('');
    if (response.length === 0) {
      $('#search-results').append("Sorry, no meetings matched your search.");
    } else {
      $('#search-results').append('<div class="row" id="mtg-search-results">' + 
        '<div class="col-xs-12" id="found-meeting-title"><h2>Meetings for <em>' + queryString + '</em></h2></div>');
      for (var meeting in response) {
        var meetingName = '<h3>' + response[meeting]["name"] + '</h3>';
        var mapLink = '<a class="view-map-link link-' + meeting + '" href="#">(view map)</a><br />';
        var meetingLocation = '<p><strong>Location: </strong>' + response[meeting]["location"] + '</p>';
        var meetingAddress = '<p><strong>Address: </strong>' + response[meeting]["address"] + '</p>';
        var meetingDay = '<p><strong>Day: </strong>' + response[meeting]["day"] + '</p>';
        var meetingTime = '<p><strong>Time: </strong>' + response[meeting]["time"] + '</p>';
        var meetingData = '<div class="individual-search-result col-xs-12">' + meetingName + mapLink + meetingLocation + meetingAddress + meetingDay + meetingTime + '</div>'
        $('#search-results').append(meetingData);
        $('#search-results').append('</div>');
      };
    };
  };

  var getLatLng = function(meeting) {
    // when done add to map
    $.ajax({
        url: 'https://maps.googleapis.com/maps/api/geocode/json?address=' + meeting["address"] + '&sensor=false',
        type: 'GET',
        dataType: 'json',
        data: '',
        success: function(response) {
          meeting["lat"] = response["results"][0]["geometry"]["location"]["lat"];
          meeting["lng"] = response["results"][0]["geometry"]["location"]["lng"];
          meetingObject = meeting;
          
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
      }).done(function(){
        if (meetingObject["lat"] !== null && meetingObject["lng"] !== null) {
          // map = L.mapbox.map('main-map', 'examples.map-20v6611k').setView([meetingObject["lng"], meetingObject["lng"]], 12)
          if ($('.map-container').hasClass('hide-map-container')) {
            $('.map-container').removeClass('hide-map-container');
          }
          addToMap(meetingObject);
          addSearchToMap();
        } else {

        }
      })
  }

  var cleanMap = function() {
    if ($('.map-container').hasClass('hide-map-container')) {
      $('.map-container').removeClass('hide-map-container');
      console.log('NEW POINT');
    } else {
      clearMarkers();
      console.log('SHOW');
    }
  }


  var markers = [];

  var addToMap = function(meeting) {

    cleanMap();
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
          title: meeting["title"],
          description: meeting["day"] + '-' + meeting["time"] + '-' + meeting["address"],
          // one can customize markers by adding simplestyle properties
          // http://mapbox.com/developers/simplestyle/
          'marker-size': 'large',
          'marker-color': '#f0a'
          // 'marker-symbol': counter
      }
    });
    markers.push(marker);
    marker.addTo(map);
    var group = new L.featureGroup(markers);

    map.fitBounds(group.getBounds());

  };


  var clearMarkers = function() {
    for (var m in markers) {
      markers[m].clearLayers();
    }
  };

  // for any of the view map links, on click, run the function
  // for(map in $('.view-map-link')) {
  var viewMapLinks = $('.view-map-link');
  var mapLinks = function() {
      $('.view-map-link').on('click', function(e) {
        e.preventDefault();
        var location = this.parentNode.children[3].innerHTML;
        meetingDetails["location"] = location[location.length - 1];
        var address = this.parentNode.children[4].innerHTML.split(">");
        meetingDetails["address"] = address[address.length - 1];
        var day = this.parentNode.children[5].innerHTML;
        meetingDetails["day"] = day[day.length - 1];
        var time = this.parentNode.children[6].innerHTML;
        meetingDetails["time"] = time[time.length - 1];
        
        getLatLng(meetingDetails);
        // addToMap(meetingDetails)
      });
    // }
  };

  var addSearchToMap = function() {
    var marker = L.mapbox.markerLayer({
      // this feature is in the GeoJSON format: see geojson.org
      // for the full specification
      type: 'Feature',
      geometry: {
          type: 'Point',
          // coordinates here are in longitude, latitude order because
          // x, y is the standard for GeoJSON and many formats
          coordinates: [parseFloat(searchAddress["lng"]), parseFloat(searchAddress["lat"])]
      },
      properties: {
          title: "Your Search",
          description: searchAddress["address"],
          // one can customize markers by adding simplestyle properties
          // http://mapbox.com/developers/simplestyle/
          'marker-size': 'large',
          'marker-color': '#0099ff'
          // 'marker-symbol': counter
      }
    });
    markers.push(marker);
    marker.addTo(map);
    var group = new L.featureGroup(markers);

    map.fitBounds(group.getBounds());
    // map.fitBounds(marker.getBounds())

  };

  // }

  $('.hide-map-link').on('click', function(e) {
    e.preventDefault();
    if ($('.map-container').hasClass('hide-map-container')) {
      // clear map marker
      // add new
    } else {
      $('.map-container').addClass('hide-map-container');
    }
  })
})();
