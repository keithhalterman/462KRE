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

  
  rule process_fs_checkin is active {
    select when foursquare checkin
     pre{
    	data = event:attr("checkin").decode();
    	}
    fired {
    	set ent:data event:attr("checkin").as("str");
    }
    
  }
   
  rule display is active {
    select when web cloudAppSelected
    
       CloudRain:createLoadPanel("Hello World! :" + data, {}, my_html);
       
    }
   
}
