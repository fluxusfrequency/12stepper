(function(){
  $(function(){
    $('.chapter-link').on('click', function(e){
      var id;
      e.preventDefault();

      id = $(e.currentTarget).html().replace(/\D+/g, "");
      $.ajax({
        url: '/api/v1/big_book/chapters/' + id,
        method: 'GET',
        dataType: 'json',
        success: function(response) {
          $('#chapter-view-panel').html(response.body);
          debugger; 
        },
        error: function(response) {
        }
      });


    });
  });

})();