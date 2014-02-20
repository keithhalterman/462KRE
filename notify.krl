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
        
        //if ent:firstname.isnull() then {
        	append('#main', form);
        	watch("#form", "submit");
        //	}
        
    }
    
    
    rule rule_1 {
        select when pageview ".*" {
            notify("Part 1 - Hello World", "This is a perminant notify.") with sticky = true;
            notify("Part 2 - Hello Again!", "This is a second notify");
        }
    }
    
   rule rule_2 {
        select when pageview ".*"
        pre {
            query = page:url("query");
            getName = function(string) {
                query.extract(re/(?:^name=(\w*))|(?:&name=(\w*))/).join("")
            };
            name = getName(query);
        }
        
        
        if (not name eq "") then {
            notify("Part 3-2", "Hello " + name) with sticky = true;  
        }
    }
    
     rule rule_2_2 {
        select when pageview ".*"
        pre {
            query = page:url("query");
            getName = function(string) {
                query.extract(re/(?:^name=(\w*))|(?:&name=(\w*))/).join("")
            };
            name = getName(query);
        }
        
        if (name eq "") then {
            notify("Part 3-2", "Hello Monkey") with sticky = true;  
        }
    }
    
    rule rule_3 {
        select when pageview ".*"
        
        if (ent:count < 5) then {
            notify("Part 5 - Page Count", "Count #" + ent:count);
        }
        
        fired {
            ent:count+=1 from 0;
        }
        
    }
    
    rule rule_4 {
        select when pageview ".*"
        
        pre {
            query = page:url("query");
            
            clearMe = query.match(re/clear/g);
            
        }
        
        if clearMe then {
            notify("clear", "cleared");
        }
        
        fired {
            clear ent:count;
        }
    }
}
