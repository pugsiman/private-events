// Override the default confirm dialog by rails
$.rails.allowAction = function(link) {
  if (link.data('confirm') == undefined) {
    return true;
  }

  $.rails.showConfirmationDialog(link);
  return false;
};

$.rails.confirmed = function(link) {
  link.data('confirm', null);
  link.trigger('click.rails');
};

$.rails.showConfirmationDialog = function(link) {
  swal({
    title: 'Are you sure?',
    text: 'You will not be able to recover this event.',
    type: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#DD6B55',
    confirmButtonText: 'Yes',
    closeOnConfirm: false,
  },
  function() {
    $.rails.confirmed(link);
    swal('Deleted!', 'Your event has been deleted.', 'success');
  });
};
