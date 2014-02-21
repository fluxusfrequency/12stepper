(function(){
  $(function(){
    $('#entries-search').on('keyup', function(){
      var query, queryData, locale;;
      query = $(this).val();
      
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
        '<div class="col-lg-2 col-md-2"><h3 class="entry-item-title">' + 
        '<a href="/en/entries">' + result['title'] + '</a></h3>' + 
        '<img class="img-responsive" src="http://placehold.it/165x70" alt="">' +
        '</div><div class="col-lg-8 col-md-8" id="entry-index-item-body"><p>' + 
        result['body'] + '</p></div><div class="col-lg-2 col-md-2">' + 
        '<ul id="entry-item-actions"><li><a href="/' + locale + '/entries/' + 
        result['id'] + '/edit">' + 'Edit</a></li><li><a data-method="delete"' +
        'href="/' + locale + '/entries/' + 
        result['id'] + '" rel="nofollow">Delete</a></li><li><a href="#">' + 
        'Share</a></li></ul>' + '</div></div><hr />';
      return view;
    };

  });
})();