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

// $.get( "/admin/pages.js", function( data ) {
//   alert( data );
// });

  // $('a[data-remote]').bind("ajax:loading", function() {
  //   $('#loading').fadeIn()
  // })

  // $('a[data-remote]').bind("ajax:complete", function() {
  //   $('#loading').fadeOut()
  // })

  // $('th a').bind("ajax:success", function(type, data) {
  //   // $.globalEval(data.substr(1, data.length-2))
  //   // $.globalEval(data.html)
  //   // alert(data);
  //   // $('#list tbody').html(data);
  //   $('#list tbody').html(data.substr(1, data.length-2));
  // })

  // $('th a').bind("ajax:failure", function(resp, data) {
  //   alert('Ошибка! '+ JSON.stringify(data))
  //   $('#list tbody').html(data.responseText);
  // })

  // $(document).on('submit', 'a[data-remote]', function(e){
  //   e.preventDefault();
  //   self = $(this);
  //   $.ajax({
  //     url: self.attr('action'),
  //     data: self.serializeArray(),
  //     type: self.attr('method'),
  //     dataType: 'json',
  //     success: function(res){ console.log(res) }
  //   })
  // });

  // $(document).on('click', 'form[data-remote]', function(e){
  //   e.preventDefault();
  //   self = $(this);
  //   $.ajax({
  //     url: self.attr('action'),
  //     data: self.serializeArray(),
  //     type: self.attr('method'),
  //     dataType: 'json',
  //     success: function(res){ console.log(res) }
  //   })
  // });

});
}(window.jQuery);
