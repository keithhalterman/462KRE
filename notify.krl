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
            	notify("Goodbye", ent:movieTitle + " is being cleared") with sticky = true;
        }
        fired {
            	clear ent:movieTitle;
          	set ent:movieTitle null;
          	
        }
    }
    
    rule show_form {
        select when pageview ".*" 
        pre {
            form = <<
                <p>Hello!</p> 
                <form id="form" onsubmit="return false">
                Movie Title: <input type="text" name="movieTitle"><br>
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
    		replace_inner("#main", "Movie " + ent:movieTitle)
    	}
    }
    
    rule clicked_rule {
        select when web submit "#form" {
        	notify("Success!", "Your Title has been searched") with sticky = true;
		replace_inner("#main", "Hello " + event:attr("movieTitle"));
        }
        fired {
       		set ent:movieTitle event:attr("movieTitle");
        }
    }
}
