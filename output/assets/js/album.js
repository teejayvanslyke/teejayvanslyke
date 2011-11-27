$(function() {

  var player = $('#player');

  var PLAYING = "&#x25BA;"
  var STOPPED = "&#x25B7;"

  player.jPlayer( {
    swfPath: "/assets/swf"
  });

  $('ol.tracklist li .play-button').click(function() {
    var button = $(this);

    player.jPlayer("setMedia", { mp3: $(this).attr('data-audio-url') });
    player.jPlayer("play");

    player.bind($.jPlayer.event.play, function(event) { // Add a listener to report the time play began
      $('ol.tracklist li .play-button').html(STOPPED);
      button.html(PLAYING);
    });
  });

});


