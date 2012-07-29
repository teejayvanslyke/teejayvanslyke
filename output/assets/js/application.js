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

