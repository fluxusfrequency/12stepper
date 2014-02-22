(function(){
  $(function(){
    $('#toc-main-panel').on('click', 'a', function(e){
      e.preventDefault();
      var id;
      id = $(e.currentTarget).attr('id').replace(/\D+/g, "");
      searchApi(id);
    });

    $('#toc-search-results-panel').on('click', 'a', function(e){
      e.preventDefault();
      var id;
      id = $(e.currentTarget).attr('id').replace(/\D+/g, "");
      searchApi(id);
    });

    function searchApi(id) {
      var locale;
      locale = document.URL.split("/")[3].replace(/\?locale\=/, "");

      $.ajax({
        url: 'api/v1/big_book/chapters/' + id,
        method: 'GET',
        dataType: 'json',
        success: function(response) {
          var chapter = findChapterTranslationForLocale(locale);
          $('#chapter-view-panel').html("<p>" + chapter + 
            response.chapter_number.toString() + "<br /><br />" + response.title + 
            "<br /><br />" + response.body.replace(/\n/g, "<br /><br />" + "</p>"));
        },
        error: function(response) {
        }
      });
    };

    $('#search-submit').on('click', function(e){
      e.preventDefault();
      var query, locale;

      query = $('#toc_search').val();
      locale = document.URL.split("/")[3].replace(/\?locale\=/, "");

      $.ajax({
        url: 'api/v1/big_book/search/' + query,
        method: 'GET',
        dataType: 'json',
        success: function(response) {
          $('#result-list').html('');
          $('#toc-main-panel').css('display', 'none');
          $('#toc-search-tabs').css('display', 'inline');
          $('#toc-search-results-panel').css('display', 'inline');
          for (var i = response.length - 1; i >= 0; i--){
            var result = "<li class='search-result-item'>" +
              "<a href='#' class='chapter-link' id='" +
              + response[i].chapter_number.toString() + "'>" + 
              findChapterTranslationForLocale(locale) + 
              response[i].chapter_number.toString() + ". " +
              response[i].chapter_title + "</a>" + "<br />" + 
              response[i].snippet + "<hr />" + "</li>";
            $("#result-list").append(result);
          }
        },
        error: function(response) {
        }
      });

    });

    $('#toc-tab').on('click', function(e) {
      e.preventDefault();
      $('#toc-main-panel').css('display', 'inline');
      $('#toc-search-results-panel').css('display', 'none');
    });

    $('#results-tab').on('click', function(e) {
      e.preventDefault();
      $('#toc-main-panel').css('display', 'none');
      $('#toc-search-results-panel').css('display', 'inline');
    });

    function findChapterTranslationForLocale(locale) {
      var message;
      if (locale === "es") {
        message = "Capítulo ";
      } else if (locale === "fr") {
        message = "Chapitre ";
      } else {
        message = "Chapter ";
      }
      return message; 
    };

    
  });

})();