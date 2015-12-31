$(function() {
  var ALERT_MSG = $('.alert');

  // clearing up the screen from flash messages
  setTimeout(function() {
    ALERT_MSG.fadeOut(1000);
  }, 6000);

  ALERT_MSG.click(function() {
    $(this).fadeOut('slow');
  });

  // subtle response css animations
  $('.intro-btn').click(function() {
    $(this).addClass('intro-btn-click');
  });

  // returns true if pass the regex matching
  function validateEmail($email) {
    var emailReg = /[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}/igm;
    return emailReg.test($email);
  };

  // clears up the login or signup form
  $('#submit-button').click(function(event) {
    var loginEmailAddress = $('input[name="session[email]"]');
    var signupEmailAddress = $('input[name="user[email]"]');

    if (loginEmailAddress.length) {
      var currentEmailAdress = loginEmailAddress.val();
      var formElements = $('form, p');
    } else {
      var currentEmailAdress = signupEmailAddress.val();
      var formElements = $('form');
    };

    if (validateEmail(currentEmailAdress)) {
      formElements.fadeOut(250);
      $('.wrapper').addClass('form-success');
    } else {
      console.log(validateEmail(currentEmailAdress));
    };
  });
});
