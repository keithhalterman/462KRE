ruleset HelloWorldApp {   //b505690x1.dev
  meta {
    name "FourSquare Checkin"
    description <<
      Hello World
    >>
    author ""
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
    use module b505204x3 alias location

  }

  rule process_fs_checkin{
    select when foursquare checkin
     pre{
    	data = event:attr("checkin").decode();
	venue = data.pick("$..venue");
	city = data.pick("$..city");
	shout = data.pick("$..shout");
	date = data.pick("$..createdAt");
    	}
    fired {
    	set ent:data event:attr("checkin").as("str");
    	set ent:venue venue;
	set ent:city city;
 	set ent:shout shout;
        set ent:date date;
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
         
         html = <<
			  <h1>Checkin Data: </h1>
			  <b>I Was At: </b> #{venue}<br/>
			  <b>In: </b> #{city}<br/>
			  <b>Yelling: </b> #{shout}<br/>
			  <b>On: </b> #{date}<br/>
			  <br>
			  <b>Data: </b> #{data} <br/>
			  <br/>
			  >>;
    }
       CloudRain:createLoadPanel("Hello World!", { },  html);
       
    }
   
}
