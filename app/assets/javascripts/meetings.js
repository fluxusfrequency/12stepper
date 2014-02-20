// (function() {
// $(function() {


//   $('#search-button').click(function(e) {
//     var queryString, queryData;
//     e.preventDefault();
//     queryString = $("#search-form").val();
//     queryData = { zipcode : queryString };
//     $.ajax({
//       url: '/meetings/search',
//       type: 'GET',
//       dataType: 'json',
//       data: queryData,
//       success: function(response) {
//         clearMarkers();
//         for (var meeting in response) {
//           console.log(response[meeting])
//           addToMap(response[meeting]);
//         }
//       },
//       error: function(response) {
//         var errors = response.responseJSON;
//         if(errors) {
//           $('#flash-section').html(errors);
//         }
//       }
//     }).done(function(response) {
//       addResults(response);
//     });
//   });

// });

// var addResults = function(response) {
//   $('#search-results').html('');
//   if (response.length === 0) {
//     $('#search-results').append("Sorry, no meetings matched your search.");
//   } else {
//     for (var meeting in response) {
//       var meetingName = '<h3>' + response[meeting]["name"] + '</h3>'
//       var meetingLocation = response[meeting]["location"] + '<br/>'
//       var meetingAddress = response[meeting]["address"] + '<br/>'
//       var meetingDay = response[meeting]["day"] + '<br/>'
//       var meetingTime = response[meeting]["time"] + '<br/>'
//       var meetingFellowship = response[meeting]["fellowship"] + '<br/>'
//       $('#search-results').append(meetingName + meetingLocation + meetingAddress + meetingDay + meetingTime + meetingFellowship);
//     };
//   };
// };

// var markers = [];

// var addToMap = function(meeting) {
//   var marker = L.mapbox.markerLayer({
//     // this feature is in the GeoJSON format: see geojson.org
//     // for the full specification
//     type: 'Feature',
//     geometry: {
//         type: 'Point',
//         // coordinates here are in longitude, latitude order because
//         // x, y is the standard for GeoJSON and many formats
//         coordinates: [parseFloat(meeting["lng"]), parseFloat(meeting["lat"])]
//     },
//     properties: {
//         title: meeting["name"],
//         description: meeting["address"],
//         // one can customize markers by adding simplestyle properties
//         // http://mapbox.com/developers/simplestyle/
//         'marker-size': 'large',
//         'marker-color': '#f0a'
//         // 'marker-symbol': counter
//     }
//   });
//   markers.push(marker);
//   marker.addTo(map);
//   // setTimeout(function() {

//   //     // wait 1 second before announcing the result
//   //   }, 1000);
//     console.log(markers);
// };


// var clearMarkers = function() {
//   for (var m in markers) {
//     markers[m].clearLayers();
//   }
// };
// })();
