// Override the default confirm dialog by rails
$.rails.allowAction = function(link) {
  if (link.data('confirm') == undefined) {
    return true;
  }

  $.rails.showConfirmationDialog(link);
  return false;
};

// User click confirm button
$.rails.confirmed = function(link) {
  link.data('confirm', null);
  link.trigger('click.rails');
};

// Display the confirmation dialog
$.rails.showConfirmationDialog = function(link) {
  swal({
    title: 'Are you sure?',
    text: 'You will not be able to recover the event.',
    type: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#DD6B55',
    confirmButtonText: 'Yes',
    closeOnConfirm: false,
  },
  function() {
    $.rails.confirmed(link);
    swal('Deleted!', 'Your imaginary file has been deleted.', 'success');
  });
};
