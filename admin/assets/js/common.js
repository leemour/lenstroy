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

  if ($('form.project').length) {
    $('#add-upload').on('click', function(ev) {
      ev.preventDefault();
      ev.stopPropagation();
      var input = $('form.project fieldset').last().clone();
      var count = input.html().match(/attributes\]\[(\d+)\]/)[1]
      count++;
      input.html(
        input.html()
        .replace(/attributes\]\[\d+\]/mg, 'attributes]['+count+']')
        .replace(/attributes_\d+/mg, 'attributes_'+count)
      );
      input.insertBefore($('#add-upload'));
    });
  }
});
}(jQuery);