var alert = $('.alert');

// clearing up the screen from flash messages
setTimeout(function() {
  alert.fadeOut('slow');
}, 8000);

// returns true if pass the regex matching
function validateEmail($email) {
  var emailReg = /[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}/igm;
  return emailReg.test($email);
};

$(function() {
  alert.click(function() {
    $(this).fadeOut('slow');
  });

  // subtle response css animations
  $('.intro-btn').click(function() {
    $(this).addClass('intro-btn-click');
  });

  // clears up the login form
  $('#login-button').click(function(event) {
    var emailaddress = $('input[name="session[email]"]').val();
    if (validateEmail(emailaddress)) {
      $('form').fadeOut(400);
      $('p').fadeOut(400);
      $('.wrapper').addClass('form-success');
    } else {
      console.log(validateEmail(emailaddress));
    };
  });

  // clears up the signup form
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
