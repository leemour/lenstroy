//= require bootstrap

$(function() {
  var counter = 0;
  var progressBar;

  function progressBarRun() {
    progressBar = setInterval(function() {
      counter += 0.14;
      if (counter > 100) {
        clearInterval(progressBar);
        $('#slider-main').carousel('next');
      }
      $(".progressbar").css("width", counter + "%");
    }, 10);
  }
  progressBarRun();


  $('#slider-main').carousel({
    interval: false
  });

  $('#slider-main').on('click', '.carousel-control', function() {
    counter = 0;
    clearInterval(progressBar);
  });

  $('#slider-main').on('slid.bs.carousel', function () {
    counter = 0;
    clearInterval(progressBar);
    if (!$('#slider-main').is(":hover")) progressBarRun();
  });

  $('#slider-main').on('mouseenter', function() {
    clearInterval(progressBar);
  });

  $('#slider-main').on('mouseleave', function() {
    clearInterval(progressBar);
    progressBarRun();
  });
});