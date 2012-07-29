$(function() {
  var container = $('.block-container')
  function runMasonry() {
    container.imagesLoaded(function() { 
      container.masonry({
        itemSelector: '.block',
        isFitWidth: true
      });
    });
  }

  $('a[rel=viewer]').click(function() {
    var href = $(this).attr('href');

    $('.viewer .loader').show();
    $('.viewer-content').html('').load(href, function() {
      $('.viewer .loader').hide();
    });

    $('html, body').addClass('noscroll');

    $('.viewer-overlay').fadeIn(100);
    $('.viewer-container').fadeIn(100);

    $('.viewer-content').click(function() { return false; });
    $('.viewer-container').click(function() {
      $('.viewer-container, .viewer-overlay').fadeOut(100);
      $('html, body').removeClass('noscroll');
    });

    return false;
  });


  $.getJSON("http://twitter.com/statuses/user_timeline/teejayvanslyke.json?callback=?", function(data) {
     $("#tweet .body p").html(data[0].text);
  });

  runMasonry();

  $('.block-link').click(function() {
    $(this).find('.block').addClass('block4').removeClass('cyan magenta green red blue')
    $(this).find('.body').show()
    runMasonry();

    return false;
  });
});

