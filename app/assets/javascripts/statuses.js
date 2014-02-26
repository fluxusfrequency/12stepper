// (function(){
//   $(function(){
//     $('.status-item').on('click', '.edit-status-link', function(e) {
//       e.preventDefault();
//       var prev = $(this).siblings(":last");
//       $(prev).html('');
//     });
//   });
// })();

var timeStamp;
var pollActivity = function() {
  queryData = {time: timeStamp, }
  $.ajax({
    url: '/api/v1/feed/statuses',
    type: "GET",
    dataType: "json",
    data: queryData,
    success: function(data) {
      console.log(data)
      // window.lastFetch = Math.floor((new Date).getTime() / 1000);
      // if (data.length > 0) {
      //   for (var i = 0; i < data.length; i++) {
      //     addActivity(data[i]);
      //   }
      //   renderActivities();
      // }
    }
  });
}

$(document).ready(function() {
  timeStamp = new Date().getTime();
})

setInterval(
  function() { pollActivity(); },
  5000);
