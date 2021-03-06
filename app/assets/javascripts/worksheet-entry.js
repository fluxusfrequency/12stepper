$(function() {


  $('#choose-a-step').change(function(){
    var queryData = {step: $('#choose-a-step').val()};
    removeEntryData();
    getEntryData(queryData);
  });

  $('#choose-a-section').change(function(){
    var queryData = {step: $('#choose-a-step').val(),
                     section: $('#choose-a-section').val()};
    removeEntryData();
    
    setNewPageData(queryData);
    
  });

  var setNewPageData = function(queryData){
    $.ajax({
      url: '/api/v1/worksheet/entries',
      type: 'GET',
      dataType: 'json',
      data: queryData,
      success: function(response) {
        setWorksheetPrompt(response);
        setEntryData(response);
        setTitle(response["worksheet"])
        if (response["entry"] !== null) {
          addExistingEntryData(response["entry"]);
        }
      },
      error: function(response) {
        var errors = response.responseJSON;
        if(errors) {
          $('#flash-section').html(errors);
        }
      }
    });
  };

  var addExistingEntryData = function(entry) {
    $('#hidden-entry-id-field').val(entry["id"]);
    $("#worksheet-entry-title").val(entry["title"]);
    $('iframe').contents().find("body").empty().append(entry["body"]).html();
  }

  var setEntryData = function(response) {
    $('#hidden-step-field').val(response["step"]);
    $('#hidden-section-field').val(response["worksheet"]["title"]);
    
  };

  var setTitle = function(worksheet) {
    $('.new-worksheet-details h4').html("<strong>Step " + worksheet["step"] + 
      "</strong> - <em>" + worksheet["title"] + "</em>");
  };

  var removeEntryData = function() {
    $("#worksheet-entry-title").val('');
    $('iframe').contents().find("body").text('');
  };

  var setWorksheetPrompt = function(response) {
    $('#worksheet-details').find('h4').empty();
    $('#worksheet-details').find('.worksheet').empty();
    $('#worksheet-details').find('.worksheet').append(response["worksheet"]["body"])
  };

  var setInitialWorksheetPrompt = function(response) {
    $('#worksheet-details').append(response["worksheet"]["body"]) 
  };

  var setNewStepValues = function(response) {
    $('#hidden-step-field').val(response["step"]);
    $('#hidden-section-field').val(response["worksheet"][0]["title"]);
    $('#choose-a-section').empty()
    for(worksheet in response["worksheet"]) {
      $('#choose-a-section').append("<option>" + response["worksheet"][worksheet]["title"] + "</option>")
    }
  };


  var clearContainers = function() {
    $('#worksheet-details').empty();
    $('#choose-a-section').empty();
  };

  var getEntryData = function(queryData) {
    $.ajax({
      url: '/api/v1/worksheet/entries',
      type: 'GET',
      dataType: 'json',
      data: queryData,
      success: function(response) {
        setNewStepValues(response);
        $('#worksheet-details').find('h4').empty()
        $('#worksheet-details').find('.worksheet').empty();
        $('#worksheet-details').find('.worksheet').append(response["worksheet"][0]["body"]);
        setEntryData(response);
        setTitle(response["worksheet"][0]);
        if (response["entry"] !== null) {
          addExistingEntryData(response["entry"]);
        }
      },
      error: function(response) {
        var errors = response.responseJSON;
        if(errors) {
          $('#flash-section').html(errors);
        }
      }
    });
  };

  $(document).ready(function(){
    var queryData = {step: $('#choose-a-step').val(),
                     section: $('#choose-a-section').val()};
    $('#hidden-step-field').val($('#choose-a-step').val())
    $('#hidden-section-field').val($('#choose-a-section').val());
  });
});

