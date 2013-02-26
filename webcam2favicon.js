// Generated by CoffeeScript 1.5.0
(function() {
  var $, error, success;

  $ = function(s) {
    return document.querySelector(s);
  };

  success = function(stream) {
    var canvas, context, drawFavicon, framerate, video;
    console.log('hi');
    video = document.createElement('video');
    video.src = window.URL.createObjectURL(stream);
    video.autoplay = true;
    $('body').appendChild(video);
    canvas = document.createElement('canvas');
    canvas.width = 16;
    canvas.height = 16;
    context = canvas.getContext('2d');
    drawFavicon = function(video) {
      var img, the_data_url;
      context.drawImage(video, 0, 0, canvas.width, canvas.height);
      the_data_url = canvas.toDataURL();
      $('#favicon').setAttribute('href', the_data_url);
      img = document.createElement('img');
      img.src = the_data_url;
      return $('body').appendChild(img);
    };
    framerate = 24;
    return setInterval((function() {
      return drawFavicon(video);
    }), 1000 / framerate);
  };

  error = function() {
    return console.log('es ist schon wieder was passiert');
  };

  navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia;

  navigator.getUserMedia({
    audio: false,
    video: true
  }, success, error);

}).call(this);
