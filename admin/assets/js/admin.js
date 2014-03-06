$('#myform').bind("ajax:loading", function() {
  // before the remote call is made.
  $('#loading').fadeIn()
})

$('#myform').bind("ajax:complete", function() {
  // after the remote call is finished.
  $('#loading').fadeOut()
})

$(document).on('submit', 'form[data-remote]', function(e){
  e.preventDefault();
  self = $(this);
  $.ajax({
    url: self.attr('action'),
    data: self.serializeArray(),
    type: self.attr('method'),
    dataType: 'json',
    success: function(res){ console.log(res) }
  })
});

$(document).on('click', 'form[data-remote]', function(e){
  e.preventDefault();
  self = $(this);
  $.ajax({
    url: self.attr('action'),
    data: self.serializeArray(),
    type: self.attr('method'),
    dataType: 'json',
    success: function(res){ console.log(res) }
  })
});