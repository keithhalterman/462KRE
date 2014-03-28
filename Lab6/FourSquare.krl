//b505690x1.dev
//Account 1: 068DF654-AFB9-11E3-8620-ECF8637EDFE5
//Account 2: 11DED720-B433-11E3-81D5-BFDA283232C8
//Account 3: 05629D2E-B433-11E3-9A1E-8283E71C24E1

// http://raw.github.com/keithhalterman/462KRE/master/Lab8/MultiFourSquare.krl

//Account 1: b505690x16
//Account 2: b505832x0
//Account 3: b505834x0

ruleset MultiFourSquare{ 
  meta {
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
    use module b505690x6 alias Location
    use module b505690x14 alias textSender
  }
  global{
    subscription_map = [
     // {"cid":"068DF654-AFB9-11E3-8620-ECF8637EDFE5"}, //Account 1
      {"cid":"11DED720-B433-11E3-81D5-BFDA283232C8"}, //Account 2
      {"cid":"05629D2E-B433-11E3-9A1E-8283E71C24E1"}  //Account 3
    ];
  }
  
  rule process_fs_checkin{
    select when foursquare checkin
    
    pre{
      data = event:attr("checkin").decode();
      venue = data.pick("$..venue");
      city = data.pick("$..city");
      shout = data.pick("$..shout");
      date = data.pick("$..createdAt");
      location = venue.pick("$..location");
      lat = location.pick("$..lat");
      lng = location.pick("$..lng");
    }
    
    {
      send_directive("A FS Checkin") with checkin = "Im Here";
      
    }
    
    fired {
      set ent:data event:attr("checkin").as("str");
      set ent:venue venue;
      set ent:city city;
      set ent:shout shout;
      set ent:date date;
      set ent:lat lat;
      set ent:lng lng;
      
      raise pds event new_location_data for Location
        with key = "fs_checkin"
        and value = {"venue" : venue.pick("$.name"), "city" : city, "shout" : shout, "date" : date, "lat" : lat, "lng" : lng};
    }
  }


  rule updateOtherApps {
    select when foursquare checkin
    foreach subscription_map setting (pid) 
          event:send(pid,"location","notification") with attrs = {"fs_checkin" : event:attr("checkin").decode()};
  }

  rule location_catch {
    select when location notification
    pre {
      data = event:attr("fs_checkin");
      venue = data.pick("$..venue");
      city = data.pick("$..city");
      shout = data.pick("$..shout");
      date = data.pick("$..createdAt");
      location = venue.pick("$..location");
      lat = location.pick("$..lat");
      lng = location.pick("$..lng");
    } 
    fired {
      set ent:data data;
      set ent:venue venue;
      set ent:city city;
      set ent:shout shout;
      set ent:date date;
      set ent:lat lat;
      set ent:lng lng;
      set ent:testing "CAUGHT THE EVENT";
    }
  }
  
  
  rule display{
    select when web cloudAppSelected
    pre{
      data = ent:data;
      venue = ent:venue.pick("$.name").as("str");
      city = ent:city.as("str");
      shout = ent:shout.as("str");
      date = ent:date.as("str");
      lat = ent:lat.as("str");
      lng = ent:lng.as("str");
      testing = ent:testing;
      
      html = <<
      <h1>Checkin Data Lab 8: </h1>
      <b>I Was At: </b> #{venue}<br/>
      <b>In: </b> #{city}<br/>
      <b>Shouting: </b> #{shout}<br/>
      <b>On: </b> #{date}<br/>
      <b>latitude: </b> #{lat}<br/>
      <b>longitude: </b> #{lng}<br/>
      <br> #{testing}
      <br>
      <b>Data: </b> #{data} <br/>
      <br/>
      >>;
    }
      CloudRain:createLoadPanel("LAST CHECKIN", { },  html);
  }
    
}
