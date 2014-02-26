// (function(){
//   $(function(){
//     $('.status-item').on('click', '.edit-status-link', function(e) {
//       e.preventDefault();
//       var prev = $(this).siblings(":last");
//       $(prev).html('');
//     });
//   });
// })();


var pollActivity = function() {
  $.ajax({
    url: '/api/v1/feed/statuses',
    type: "GET",
    dataType: "json",
    success: function(data) {
      console.log('YEAH')
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

// setInterval(
//   function() { pollActivity(); },
//   5000);
