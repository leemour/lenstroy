//= require bootstrap

$('.carousel').on('click', '.carousel-control', function() {
  $('.carousel').carousel('pause');
});
$(document).on('mouseleave', '.carousel', function() {
  $(this).carousel('pause');
});