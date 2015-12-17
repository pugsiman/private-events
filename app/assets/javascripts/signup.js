$(function() {
  // returns true if pass the regex matching
  function validateEmail($email) {
    var emailReg = /[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}/igm;
    return emailReg.test($email);
  };

  // clears up the form
  $('#signup-button').click(function(event) {
    var emailaddress = $('input[name="user[email]"]').val();
    if (validateEmail(emailaddress)) {
      $('form').fadeOut(400);
      $('.wrapper').addClass('form-success');
    } else {
      console.log(validateEmail(emailaddress));
    };
  });
});
