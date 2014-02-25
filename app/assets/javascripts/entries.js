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
          entrySearchAndHighlight(query);
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

    $('#toggle-worksheet').on("click", function() {
      toggleLink();
      console.log($('#toggle-worksheet'))
    })

    function toggleLink() {
      if ($('#toggle-worksheet').html() === "Show Worksheet") {
        $('#toggle-worksheet').empty().html("Hide Worksheet");
        $('.toggled-worksheet-details').removeClass('hide-worksheet-details');
        $('.toggled-worksheet-details').addClass('col-lg-5');
        $('.worksheet-body-details').addClass('worksheet');

        $('#entry-text-input').addClass('col-lg-7');
      } else {
        $('#toggle-worksheet').empty().html("Show Worksheet");
        $('.toggled-worksheet-details').addClass('hide-worksheet-details');
        $('.toggled-worksheet-details').removeClass('worksheet col-lg-5');
        $('#entry-text-input').removeClass('col-lg-7');
      }
    }
  });

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
}


