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
    	}
    fired {
    	set ent:data event:attr("checkin").as("str");
    }
    
  }
   
  rule display{
    select when web cloudAppSelected
    pre{
         v = ent:data;
         html = <<
			  <h1>Checkin Data:</h1>
			  <b>I Was At: </b> #{v}<br/>
			  <b>In: </b> <br/>
			  <b>Yelling: </b> <br/>
			  <b>On: </b> <br/>
			  <b> AND NOW IM GONE </b>
			  <br/>
			  >>;
    }
       CloudRain:createLoadPanel("Hello World!", { },  html);
       
    }
   
}
