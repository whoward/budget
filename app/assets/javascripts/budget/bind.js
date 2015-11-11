
$(document).ready(function() {
  $(document).trigger('bind');
});

window.bind = function(selector, callback) {
  $(document).on("bind", function() {
    $(selector, this).each(function() {
      var $this = $(this);

      if($this.data('instance')) return;

      $this.data('instance', callback($this));
    });
  });
};
