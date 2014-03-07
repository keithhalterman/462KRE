ruleset HelloWorldApp {
  meta {
    name "FourSquare Checkin"
    description <<
      Hello World
    >>
    author ""
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
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
    }
    
  }
   
  rule display{
    select when web cloudAppSelected
    pre{
        data = ent:data;
        venue = ent:data.pick("$..venue");
	city = data.pick("$..city");
	shout = data.pick("$..shout");
	date = data.pick("$..createdAt");
         
         html = <<
			  <h1>Checkin Data:</h1>
			  <b>I Was At: </b> #{venue}<br/>
			  <b>In: </b> #{city}<br/>
			  <b>Yelling: </b> #{shout}<br/>
			  <b>On: </b> #{date}<br/>
			  <br/>
			  >>;
    }
       CloudRain:createLoadPanel("Hello World!", { },  html);
       
    }
   
}
