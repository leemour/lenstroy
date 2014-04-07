!function($) {
'use strict';
$(function() {
  $('#list a.title-link').on('click', function(ev) {
    ev.stopPropagation();
  });

  $('select.parent').on('change', function(ev) {
    var url = $("option:selected", this).data('uri');
    if (url) window.location = url;
    return false;
  });

});
}(window.jQuery);
