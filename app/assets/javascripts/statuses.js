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
      if (data.length > 0) {
        $('#feed-activity').prepend('<div class="row status-item" id=<%= "status-' + 
            data[0]["status"]["id"] + '" > <div class="col-lg-3"><p><img alt="" class="status-token" src="/assets/' + data[0]["token"] 
            + '"><a class="status-username" href="/en/profile/' + data[0]["user"]["username"] + '"> ' + 
            data[0]["user"]["username"] + '</a></p><p class="status-time">' + data[0]["posted_at"] + '</p></div><div class="col-lg-8"><p>'
            + data[0]["status"]["content"] + '</p></div></div>'
          )
        timeStamp = new Date().getTime();
      }
    }
  });
}



$(document).ready(function() {
  timeStamp = new Date().getTime();
})

setInterval(
  function() { pollActivity(); },
  5000);
