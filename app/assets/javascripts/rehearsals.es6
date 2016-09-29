ZiggeoApi.Events.on("system_ready", function() {
  // we search for our embedding using the getElementById to find the element first and then to find the video object within the same
  var recorder = ZiggeoApi.V2.Recorder.findByElement( document.getElementById('recorderElement') );

  function postVideoToken(videoToken, streamToken){

    $form = $('#rehearsalsForm');
    $ziggeotoken = $('#rehearsal_video_token');
    $webtoken = $('#rehearsal_token');
    $ziggeotoken.val(videoToken);
    $webtoken.val(streamToken)
    $form.submit();
  };

  recorder.on('verified', function() {
    // console.log(streamToken);
    // getting the streamtoken and storing it in streamToken var to ship it to the outside world
    var streamToken = recorder.get('stream'); //to get the stream token
    var videoToken = recorder.get('video'); //to get the video token
    // console.log(videoToken);
    // console.log(streamToken);

    var nextRehearsal= $(".list_of_lesson_rehearsals > div").length + 1;
    var newrehearsal = `<div class="rehearsal_thumbnail">`+
                `Rehearsal `+nextRehearsal+`<br>`+
                `<img src="`+videoImage(videoToken)+`" width="100%" class="rehearsal_img rehearsal_`+nextRehearsal+`">`+
                `</div>`;
    $('.list_of_lesson_rehearsals').append(newrehearsal)

    // here is where we call the postVideoToken function and pass it both token vars
    postVideoToken(videoToken, streamToken);
  });
});


var pageReady = function(){
    $('.user_bubble').click(function (event) {
    event.preventDefault()
   console.log($(this).data('rehearsal_id'));
    console.log('clicked');
});




};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);