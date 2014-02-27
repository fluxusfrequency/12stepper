(function(){

  var locale = document.URL.split("/")[3].replace(/\?locale\=/, "");
  
  $(function(){
    $('#entries-search').on('keyup', function(){
      var query, queryData;
      query = $(this).val();
      if (query === "") {
        query = " ";
      }
      
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
          entrySearchAndHighlight(query);
        },
        error: function(response) {
          
        }
      });
    });

    function buildResultView(result, locale) {
      result['step'] = result['step'] || "";
      var view = '<div class="row" id="entry-index-item-row">' +
      '<div class="col-lg-3 col-md-3">' + 
      '<h4 class="entry-item-title"><a href="' + '/entries/' +
      result['id'] + '/edit">' + result['title'] + '</a></h4>' +
      '<p class="entry-date">' + result['created_at'].slice(5, 7) + "/" +
      result['created_at'].slice(8, 10) + "/" + result['created_at'].slice(0, 4) +
      '</p><p class="entry-step">' + stepTranslation(locale) + result['step'].toString() + 
      '</p></div><div class="col-lg-7 col-md-7" id="entry-index-item-body"><p>' +
      result['body'] + '</p></div><div class="col-lg-2 col-md-2">' +
      '<ul id="entry-item-actions"><li><a href="' + '/entries/' +
      result['id'] + '/edit">Edit</a></li><li><a data-method="delete" href="' +
      '/entries/' + result['id'] + '" rel="nofollow">Delete</a></li>' +
      '<li><a href="#">Share</a></li></ul></div></div>';

      return view;
    };

    function stepTranslation(locale) {
      if (locale === "es") {
        return "Paso: ";
      } else if (locale === "fr") {
        return "Étape: ";
      } else {
        return "Step: ";
      }
    }

    $('.toggle-status-content').on("click", function(e) {
      e.preventDefault();
      if(this.innerHTML === "(" + moreTranslation(locale) + ")") {
        $("#status-content-" + this.id.split('-')[2]).removeClass('hide-status-content');
        this.innerHTML = "(" + lessTranslation(locale) + ")";
      } else {
      $("#status-content-" + this.id.split('-')[2]).addClass('hide-status-content');
        this.innerHTML = "(" + moreTranslation(locale) + ")";
      }
    });

    function moreTranslation(locale) {
      if (locale === "es") {
        return "más";
      } else if (locale === "fr") {
        return "plus";
      } else {
        return "more";
      }
    }

    function lessTranslation(locale) {
      if (locale === "es") {
        return "menos";
      } else if (locale === "fr") {
        return "moins";
      } else {
        return "less";
      }
    }

    $('#toggle-worksheet').on("click", function(e) {
      e.preventDefault();
      toggleLink();
    });

    function toggleLink() {
      var triggerText = $('#toggle-entry-worksheet').html();
      var i = showWorksheetTranslations.indexOf(triggerText);
      var j = hideWorksheetTranslations.indexOf(triggerText);
      if (i !== -1) {
        $('#toggle-worksheet').empty().html(hideWorksheetTranslations[i]);
        $('.toggled-worksheet-details').removeClass('hide-worksheet-details');
        $('.toggled-worksheet-details').addClass('col-lg-5');
        $('.worksheet-body-details').addClass('worksheet');

        $('#entry-text-input').addClass('col-lg-7');
      } else {
        $('#toggle-worksheet').empty().html(showWorksheetTranslations[j]);
        $('.toggled-worksheet-details').addClass('hide-worksheet-details');
        $('.toggled-worksheet-details').removeClass('worksheet col-lg-5');
        $('#entry-text-input').removeClass('col-lg-7');
      }
    }

    $('#toggle-entry-worksheet').on("click", function(e) {
      e.preventDefault();
      toggleEntryLink();
    });

    function toggleEntryLink() {
      var triggerText = $('#toggle-entry-worksheet').html();
      var i = showWorksheetTranslations.indexOf(triggerText);
      var j = hideWorksheetTranslations.indexOf(triggerText);
      if (i !== -1) {
        $('#toggle-entry-worksheet').empty().html(hideWorksheetTranslations[i]);
        $('.new-worksheet-details').removeClass('hide-worksheet-details');
        $('.new-worksheet-details').addClass('col-lg-5');
        $('#worksheet-entry-text').addClass('col-lg-7');
      } else {
        $('#toggle-entry-worksheet').empty().html(showWorksheetTranslations[j]);
        $('.new-worksheet-details').addClass('hide-worksheet-details');
        $('.new-worksheet-details').removeClass('col-lg-5');
        $('#worksheet-entry-text').removeClass('col-lg-7');
        $('#worksheet-entry-text').addClass('col-lg-12');
      }
    }
  });

  var showWorksheetTranslations = [
    "Show Worksheet", 
    "Mostrar Hoja de Trabajo", 
    "Afficher Feuille"];

  var hideWorksheetTranslations = [
    "Hide Worksheet",
    "Ocultar Hoja de Trabajo",
    "Masquer Feuille"
  ]

})();

CKEDITOR.editorConfig = function( config )
{
    config.toolbar_MyToolbar =
    [
        { name: 'document', items : [ 'NewPage','Preview' ] },
        { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
        { name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','Scayt' ] },
        { name: 'insert', items : [ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'
                 ,'Iframe' ] },
                '/',
        { name: 'styles', items : [ 'Styles','Format' ] },
        { name: 'basicstyles', items : [ 'Bold','Italic','Strike','-','RemoveFormat' ] },
        { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote' ] },
        { name: 'links', items : [ 'Link','Unlink','Anchor' ] },
        { name: 'tools', items : [ 'Maximize','-','About' ] }
    ];
};
