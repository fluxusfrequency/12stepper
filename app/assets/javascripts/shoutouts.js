(function() {
  $(function() {
    $('#new-status-field').on('keyup', function(){
      var query, shoutout, formData;
      formData = $(this).val();

      if (formData.indexOf("@") === -1) {
        console.log('not a shoutout');
        return;
      }

      shoutout = formData.match(/@\S+/g) || [""];
      query = shoutout[0];
      
      $.ajax({
        url: 'api/v1/users/search/' + query,
        type: 'GET',
        dataType: 'json',
        success: function(response) {
          if (response === 404) { return; }
          $('.shoutouts-panel').html('');
          $('.shoutouts-panel').removeClass('hidden');
          for (var i = 0; i < response.length; i++) {
            if(response[i]) { appendUsername(response[i]); }
          }
          return false;
        }
      });

      function appendUsername(username) {
        var link = "<a href='#' class='shoutout-link'>" + username + '</a>';
        $('.shoutouts-panel').append(link);
      }

      function setupShoutoutsClick() {
        $('.shoutouts-panel').on('click', '.shoutout-link', function(e){
          e.preventDefault();
          e.stopPropagation();
          $('.shoutouts-panel').addClass('hidden');
          $('.shoutouts-panel').html('');
          tagUsername(this.text);
          return false;
        });
      }

      function tagUsername(username) {
        var text = "<p>" + username + "</p>";
        $('.shoutouts-chosen').append(text);
        $('.shoutouts-chosen').removeClass('hidden');
        return false;
      }

    });
    // setupShoutoutsClick();
  });
})();