webcam2favicon 
----------------------
hi, this is an execise for literate programming. i'm creating a webcam2favicon pseudo streamer with plain HTML5 apis and literate coffeescript.

you might ask: hey, what is [literate coffeescript](http://coffeescript.org/#literate)? well, basically you can not compile coffeescript within a markdown file into actual working javascript.

why? the idea behind [literate programming](http://en.wikipedia.org/wiki/Literate_programming) (by a guy named [knuth](http://en.wikipedia.org/wiki/Donald_Knuth)) is to explain everything in coding as code is just another kind of story. to be honest, i never read the book, but i read [coders at work](http://www.codersatwork.com/) and they talk about knuth a lot. (great book by the way)

but get one with the fun

first we create a simple jquery thingie, because i want to

    $ = (s) -> document.querySelector(s)

yeah, that is fun.

ok, we google to find out how that getUserMethod really works. ok got it.

we need a success callback function that gets handled a stream object

    success = (stream) ->
      console.log('hi')

we want to do something with the stream and as i don't know how we just turn it into a video
    
      video = document.createElement('video')
      video.src = window.URL.createObjectURL(stream)

as we love visual feedback lets add the video to the body

      video.autoplay=true
      $('body').appendChild(video)

ok, but the goal is to get the webcam into the favicon, hmm, hmmm, we draw the video into a canvas (and resize it to 16px16px favicon size)

      canvas = document.createElement('canvas')
      canvas.width=16
      canvas.height=16
      context = canvas.getContext('2d')

a function to draw the canvas stuff into the favicon

      drawFavicon = (video) ->
        context.drawImage(video,0,0,canvas.width,canvas.height)
        the_data_url = canvas.toDataURL()
        #console.log('test')
        #console.log(the_data_url)
        $('#favicon').setAttribute('href', the_data_url)

for testing purposes and for the effect we also render the small favicons to the body

        img = document.createElement('img')
        img.src = the_data_url
        $('body').appendChild(img)

i think we go with a 

      framerate = 24

per second.
    
      setInterval((()->drawFavicon(video)), 1000/framerate)

ok, but we are pretty deep down in the rabbit hole already, this is only just the success handler, we still need an error handler and well something to call all these callbacks

    error = () -> console.log('es ist schon wieder was passiert')

ok, now to call all this stuff via getUserMedia, but uh oh i think getUserMedia is still prefixed in webkit, just to make sure

    navigator.getUserMedia  = navigator.getUserMedia or navigator.webkitGetUserMedia

now to the real work

    navigator.getUserMedia({audio: false, video: true}, success, error)

to be honest, i don't believe this will work. but hey, it works

ok thx, fork on github.
