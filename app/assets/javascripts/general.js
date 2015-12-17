var alert = $('.alert');

// clearing up the screen from flash messages
setTimeout(function() {
  alert.fadeOut('slow');
}, 8000);

$(function() {
  alert.click(function() {
    $(this).fadeOut('slow');
  });

  // subtle response css animations
  $('.intro-btn').click(function() {
    $(this).addClass('intro-btn-click');
  });
});
