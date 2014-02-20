ruleset a1299x176 {
    meta {
        name "Lab 2"
        author "Keith Halterman"
        logging off
    }
    dispatch {
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
        	append("#main", form);
        	watch("#form", "submit");
        }
    }
    
    rule show_name {
    	select when pageview ".*"
    	replace_inner("#main", "Hello " + event:attr("firstname") + " " +  event:attr("lastname"));
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
