//= require bootstrap


// $(document).on('mouseleave', '#slider-main', function() {
//   $(this).carousel('pause');
// });

$('#slider-main').carousel({
  interval: 7500
})


$('#slider-main').on('click', '.carousel-control', function() {
  $(this).carousel('pause');
});

$(document).off('mouseleave', '.carousel');
$(document).off('mouseleave', '#slider-main');


$(function() {
  var counter = 0;
  var progressBar;

  function progressBarRun() {
    progressBar = setInterval(function() {
      counter += 0.133;
      if (counter > 100) clearInterval(progressBar);
      $(".progressbar").css("width", counter + "%");
    }, 10);
  }
  progressBarRun();

  $('#slider-main').on('slid.bs.carousel', function () {
    counter = 0;
    clearInterval(progressBar);
    progressBarRun();
  });

  $('#slider-main').on('mouseenter', function() {
    counter = 0;
    clearInterval(progressBar);
  });

  $('#slider-main').on('mouseleave', function() {
    progressBarRun();
  });
});