$(document).ready(function() {

  "use strict";
  //calling map and setting view to a static location
  var map = L.map('map').setView([0, 0.1], 3); /*{maxBounds: [[90, -180], [-90, 180]] }). */ 

    L.tileLayer('http://{s}.tile.cloudmade.com/f644205df10c4e16a94c5c9b74438873/998/256/{z}/{x}/{y}.png', {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
        maxZoom: 18,
        minZoom: 1   
    }).addTo(map);

    var aboutCoords = [37.769581, -122.423243];
    var aboutMarker = 
      L.marker([37.769581, -122.423243])
        .addTo(map)
        .bindPopup("<div class='top about-marker'>" 
          + "<img src='assets/brian1.png'" 
          + "width='60'> <div class='popup-text'>"  
          + "<div class='title-wrapper'><a href='http://www.brianschroer.co'" 
          + "target='_blank'>" 
          + "Brian Schroer"
          + "</a> </span></div> <span class='blurb'>Brian is full-stack web developer with" 
          + " a particular interest in UX and front-end development. He was inspired to build" 
          + " Grooves to help people discover eclectic music in a different way. Check out" 
          + " more of his work <a href='http://www.brianschroer.co' target='_blank' class='brian-link'>"
          + " here.</a></span></div> </div>" )
        .on("click", function() { map.setView(aboutCoords, 4);
        });

  mapObject = map;
  //TRACKS STUFF
  _.templateSettings = {
    interpolate : /\{\{(.+?)\}\}/g
  };

  //calling tracks from the database and then displaying on map
  $.ajax(
  '/get_database_tracks',
  { success: function(lastTracks){
    var trackUrlConcatStrings = "";
    
    // Iterate through called tracks and bind to map marker.
    // Popup track info and play track upon click
    _.each(lastTracks, function(lastTrack) {

      trackObjects.push(lastTrack);
      
      var marker = 
      L.marker(lastTrack.coordinates)
        .addTo(map)
        .bindPopup("<div class='top'>" 
          + "<img src='" + lastTrack.user_avatar_url
          + "'width='60'> <div class='popup-text'>"  
          + "<div class='title-wrapper'><a href='http://soundcloud.com/" 
          + lastTrack.user_permalink + "/" + lastTrack.track_permalink 
          + "'target='_blank'>" 
          + lastTrack.track_name 
          + "</a></div><span class='name'>" 
          + lastTrack.username  
          + "</span><br><span class='location'>" 
          + lastTrack.user_city + ", " + lastTrack.user_country 
          + "</span></div></div>")
        .on("click", function(event) {var trackId = lastTrack.track_id;
        onMarkerClick(trackId);
        })
        .on("click", function() { map.setView(lastTrack.coordinates, 4);
        })
       // if i.zero? 
        // .openPopup();
       // end
      var trackUrlString = "<a href='http://soundcloud.com/" + lastTrack.user_permalink 
        + "/" + lastTrack.track_permalink + "'></a>"; 
      trackUrlConcatStrings += trackUrlString;
      trackMarkers.push(marker);
      trackMarkers[0].openPopup();
    });
    
    map.setView(trackObjects[0].coordinates, 3);    
    var template = '<div class="sc-player">' + trackUrlConcatStrings + '</div>';
    var widgetContainer = document.getElementsByClassName("widget-container")[0];
    var currentTrack = _.template(template, 'null');
    widgetContainer.innerHTML+= currentTrack;

    var scPlayerScript = document.createElement("script");
    scPlayerScript.setAttribute("src", "/sc-player.js");
    var body = document.getElementsByTagName("body")[0];
    body.appendChild(scPlayerScript);
    }
  });

  
  // Call more tracks 

  $('.get-more-tracks').click(function(){
    trackMarkers.length = 0;
    trackObjects.length = 0;
    $('.sc-player, .sc-player-engine-container').remove();
    $('.sc-player.playing a.sc-pause').click();
    var scripts = document.getElementsByTagName("script");
    var scPlayerScriptTag = scripts[scripts.length-1];
    scPlayerScriptTag.remove();
    
    $.ajax(
    '/get_database_tracks',
    { success: function(lastTracks){
      var trackUrlConcatStrings = "";
      
      //iterate through called tracks and bind to map marker: 
      //popup track info and play track upon click
      _.each(lastTracks, function(lastTrack) {
        
        trackObjects.push(lastTrack);
        var marker = 
        L.marker(lastTrack.coordinates)
          .addTo(map)
            .bindPopup("<div class='top'>" 
              + "<img src='" + lastTrack.user_avatar_url
              + "'width='60'> <div class='popup-text'>"  
              + "<div class='title-wrapper'><a href='http://soundcloud.com/" 
              + lastTrack.user_permalink + "/" + lastTrack.track_permalink 
              + "'target='_blank'>" 
              + lastTrack.track_name 
              + "</a></div><span class='name'>" 
              + lastTrack.username  
              + "</span><br><span class='location'>" 
              + lastTrack.user_city + ", " + lastTrack.user_country 
              + "</span></div></div>")
          .on("click", function(event) {var trackId = lastTrack.track_id;
          onMarkerClick(trackId);
          })
          .on("click", function() { map.setView(lastTrack.coordinates, 4);
          });
          trackMarkers.push(marker);
          trackMarkers[0].openPopup();

        var trackUrlString = "<a href='http://soundcloud.com/" + lastTrack.user_permalink 
          + "/" + lastTrack.track_permalink + "'></a>"; 
        trackUrlConcatStrings += trackUrlString;
      });
      
      map.setView(trackObjects[0].coordinates, 3);    
      var template = '<div class="sc-player">' + trackUrlConcatStrings + '</div>';
      var widgetContainer = document.getElementsByClassName("widget-container")[0];
      var currentTrack = _.template(template, 'null');
      widgetContainer.innerHTML = currentTrack;

      var scPlayerScript = document.createElement("script");
      scPlayerScript.setAttribute("src", "/sc-player.js");
      var body = document.getElementsByTagName("body")[0];
      body.appendChild(scPlayerScript);
      }
    });
  });
  
  // Pull up about-me bubble
  var about = $('.about-link');
    about.on('click', function(){
      aboutMarker.openPopup();
      map.setView(aboutCoords, 4);
    })
  //pulls up popup window on clicked marker and closes other popup windows. intended to switch song also.
  function onMarkerClick(trackId) {
    $(".track").hide();
    $("#track-" + trackId).show().find(".sc-trackslist a").click();
  }
  
});
