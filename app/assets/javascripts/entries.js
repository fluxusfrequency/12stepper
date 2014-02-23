(function(){
  $(function(){
    $('#entries-search').on('keyup', function(){
      var query, queryData, locale;;
      query = $(this).val();
      if (query === "") {
        query = " ";
      }
      
      locale = document.URL.split("/")[3].replace(/\?locale\=/, "");
      queryData = { query: query };

      $.ajax({
        url: 'api/v1/entries/search/' + query,
        type: 'GET',
        dataType: 'json',
        data: queryData,
        success: function(response) {
          $('#entry-list-container').html('');
          for (var i = 0; i < response.length; i++) {
            $('#entry-list-container').append(buildResultView(response[i], locale));
          }
        },
        error: function(response) {
          
        }
      });
    });

    function buildResultView(result, locale) {
      var view = '<div class="row" id="entry-index-item-row">' +
      '<div class="col-lg-3 col-md-3">' + 
      '<h4 class="entry-item-title"><a href="' + '/entries/' +
      result['id'] + '/edit">' + result['title'] + '</a></h4>' +
      '<p class="entry-date">' + result['created_at'].slice(5, 7) + "/" +
      result['created_at'].slice(8, 10) + "/" + result['created_at'].slice(0, 4) +
      '</p><p class="token-label">Icon: </p><img class="entry-token"' + 
      'src="/assets/green_token_sm.png" /></div>' + 
      '<div class="col-lg-7 col-md-7" id="entry-index-item-body"><p>' +
      result['body'] + '</p></div><div class="col-lg-2 col-md-2">' +
      '<ul id="entry-item-actions"><li><a href="' + '/entries/' +
      result['id'] + '/edit">Edit</a></li><li><a data-method="delete" href="' +
      '/entries/' + result['id'] + '" rel="nofollow">Delete</a></li>' +
      '<li><a href="#">Share</a></li></ul></div></div>';

      return view;
    };
  });
})();