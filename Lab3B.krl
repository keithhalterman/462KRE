ruleset a1299x176 {
    meta {
        name "Lab 2"
        author "Keith Halterman"
        logging off
    }
    dispatch {
    }
    
    rule clear_names {
        select when pageview ".*"
        pre {
            query = page:url("query");
            getName = function(string) {
                query.extract(re/(?:^clear=(\w*))|(?:&clear=(\w*))/).join("")
            };
            name = getName(query);
        }
        
        
        if (name eq "1") then {
            	notify("Goodbye", ent:firstname + " is being cleared") with sticky = true;
        }
        fired {
            	clear ent:firstname;
        	clear ent:lastname;
          	set ent:firstname null;
          	set ent:lastname null;
        }
    }
    
    rule show_form {
        select when pageview ".*" 
        pre {
            form = <<
                <p>Hello!</p> 
                <form id="form" onsubmit="return false">
                First name: <input type="text" name="firstname"><br>
                Last name: <input type="text" name="lastname">
                <input type="submit" value="Submit">
                </form>
            >>;
        } 
        
        if ent:firstname.isnull() then {
        	notify("Welcome!", "Please enter your name") with sticky = true;
        	append("#main", form);
        	watch("#form", "submit");
        }
    }
    
    rule show_name {
    	select when pageview ".*"
    	if not ent:firstname.isnull() then {
    		replace_inner("#main", "Hello " + ent:firstname + " " +  ent:lastname);
    	}
    }
    
    rule clicked_rule {
        select when web submit "#form" {
        	notify("Success!", "Your name has been saved") with sticky = true;
		replace_inner("#main", "Hello " + event:attr("firstname") + " " +  event:attr("lastname"));
        }
        fired {
       		set ent:firstname event:attr("firstname");
		set ent:lastname event:attr("lastname");
        }
    }
}
