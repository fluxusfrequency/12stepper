(function(){
  $(function(e){
    $('#entries_search_meetings_search').on('keyup', function(){

      var query, queryData, locale;
      query = $(this).val();
      locale = document.URL.split("/")[3];
      queryData = { query: query };

      // console.log(query);
      
      $.ajax({
        url: "/" + locale + '/api/v1/entries/search/' + query,
        type: 'POST',
        dataType: 'json',
        data: queryData,
        success: function(response) {
          debugger;
        },
        error: function(response) {
          debugger;
        }
      });
    });
  })
})();