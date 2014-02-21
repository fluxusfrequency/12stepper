(function(){
  $(function(){
    $('#password').hide();
    $('#new_password').hide();
    $('#new_password_confirmation').hide();

    $('#fake_password').show();
    $('#new_fake_password').show();
    $('#new_fake_password_confirmation').show();

    $('#fake_password').focus(function(){
      $(this).hide();
      $('#password').show().focus();
    });

    $('#new_fake_password').focus(function(){
      $(this).hide();
      $('#new_password').show().focus();
    });

    $('#new_fake_password_confirmation').focus(function(){
      $(this).hide();
      $('#new_password_confirmation').show().focus();
    });

    $('#password').blur(function(){
      if($(this).val() === ""){
        $(this).hide();
        $('#fake_password').show();
      }
    });

    $('#new_password').blur(function(){
      if($(this).val() === ""){
        $(this).hide();
        $('#new_fake_password').show();
      }
    });

    $('#new_password_confirmation').blur(function(){
      if($(this).val() === ""){
        $(this).hide();
        $('#new_fake_password_confirmation').show();
      }
    });
  });
})();