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
                <p>A Wild Form Is Approaching</p> 
                <form id="form" onsubmit="return false">
                First name: <input type="text" name="firstname"><br>
                Last name: <input type="text" name="lastname">
                <input type="submit" value="Submit">
                </form>
            >>;
        } 
        
        //set ent:firstname null;
        
        if ent:firstname.isnull() then {
        	append("#main", form);
        	watch("#form", "submit");
        }
        
        
    }
}
