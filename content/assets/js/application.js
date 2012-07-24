$(function() {
  $('.block-container').masonry({
    itemSelector: '.block',
    isFitWidth: true,
    columnWidth: 193
  });

  $('.block-link').click(function() {
    $(this).find('.block').css({
      position: 'fixed',
      zIndex: '100000'
    }).animate({
      top: '0px',
      left: '0px',
      width: '100%',
      height: '100%'
    }, function() {
      $(this).find('.back').fadeIn();
    });

    return false;
  });
});

