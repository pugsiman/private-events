$(function() {
  // clearing up the screen from flash messages
  var alert = $('.alert');

  setTimeout(function() {
    alert.fadeOut('slow');
  }, 8000);

  alert.click(function() {
    $(this).fadeOut('slow');
  });

  // subtle response css animations
  $('.intro-btn').click(function() {
    $(this).addClass('intro-btn-click');
  });
});
