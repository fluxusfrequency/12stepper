$(function() {


  $('#choose-a-step').change(function(){
    var queryData = {step: $('#choose-a-step').val()};
    getEntryData(queryData);
    
  })

  $('#choose-a-section').change(function(){
    var queryData = {step: $('#choose-a-step').val(),
                     section: $('#choose-a-section').val()};
    setNewPageData(queryData);
    
  })

  var setNewPageData = function(queryData){
    $.ajax({
      url: '/api/v1/worksheet/entries',
      type: 'GET',
      dataType: 'json',
      data: queryData,
      success: function(response) {
        // console.log(response)
        setWorksheetPrompt(response);
        setEntryData(response);
      },
      error: function(response) {
        var errors = response.responseJSON;
        if(errors) {
          $('#flash-section').html(errors);
        }
      }
    })
  }

  var setEntryData = function(response) {
    // console.log(response)
    $('#hidden-step-field').val(response["step"]);
    $('#hidden-section-field').val(response["worksheet"]["title"]);
    if (response["entry"].length !== 0) {
    $('#hidden-entry-id-field').val(response["entry"][0]["id"]);
      $("#worksheet-entry-title").val(response["entry"][0]["title"])
    }
  }

  var setWorksheetPrompt = function(response) {
    $('#worksheet-details').empty();
    $('#worksheet-details').append(response["worksheet"]["body"])
  };

  var setInitialWorksheetPrompt = function(response) {
    $('#worksheet-details').append(response["worksheets"][0]["body"]) 
  };

  var setNewStepValues = function(response) {
    $('#hidden-step-field').val(response["step"]);
    $('#hidden-section-field').val(response["worksheets"][0]["title"]);
    for(worksheet in response["worksheets"]) {
      $('#choose-a-section').append("<option>" + response["worksheets"][worksheet]["title"] + "</option>")
    }
  };

  var clearContainers = function() {
    $('#worksheet-details').empty();
    $('#choose-a-section').empty();
  }

  var getEntryData = function(queryData) {
    $.ajax({
      url: '/api/v1/worksheet/entries',
      type: 'GET',
      dataType: 'json',
      data: queryData,
      success: function(response) {
        clearContainers();
        setNewStepValues(response);
        setInitialWorksheetPrompt(response);
      },
      error: function(response) {
        var errors = response.responseJSON;
        if(errors) {
          $('#flash-section').html(errors);
        }
      }
    })
  }

  $(document).ready(function(){
    var queryData = {step: $('#choose-a-step').val(),
                     section: $('#choose-a-section').val()};
    setNewPageData(queryData);
  })
})
// $('.worksheet').hide()
// $('#worksheet-entry-text').removeClass('col-lg-12').addClass('col-lg-7')
