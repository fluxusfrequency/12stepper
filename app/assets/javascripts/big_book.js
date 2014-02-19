(function(){
  $(function(){
    $('.chapter-link').on('click', function(e){
      var id, locale;
      e.preventDefault();

      id = $(e.currentTarget).html().replace(/\D+/g, "");
      locale = document.URL.split("/")[3];

      $.ajax({
        url: "/" + locale + '/api/v1/big_book/chapters/' + id,
        method: 'GET',
        dataType: 'json',
        success: function(response) {
          var chapter = findChapterTranslationForLocale(locale);
          $('#chapter-view-panel').html(chapter + 
            response.chapter_number.toString() + "<br />" + response.title + 
            "<br />" + response.body);
        },
        error: function(response) {
        }
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
      }

    });
  });

})();