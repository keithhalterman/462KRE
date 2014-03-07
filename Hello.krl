ruleset HelloWorldApp {
  meta {
    name "Hello World"
    description <<
      Hello World
    >>
    author ""
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
  }
  dispatch {
  }
  global {
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
         v = ent:data
         html = <<
			  <h1>Checkin Data:</h1>
			  <b>I Was At: </b> #{e}<br/>
			  <b>In: </b> #{c}<br/>
			  <b>Yelling: </b> #{s}<br/>
			  <b>On: </b> #{ca}<br/>
			  <b> AND NOW IM GONE </b>
			  <br/>
			  >>;
    }
       CloudRain:createLoadPanel("Hello World!", { },  html);
       
    }
   
}
