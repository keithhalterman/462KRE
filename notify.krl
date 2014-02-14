ruleset a1299x176 {
    meta {
        name "Lab 2"
        author "Keith Halterman"
        logging off
    }
    dispatch {
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
                query.extract(re/(?:name=(\w*))/).join("")
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
                query.extract(re/(?:name=(\w*))/).join("")
            };
            name = getName(query);
        }
        
        if (name eq "") then {
            notify("Part 3-2", "Hello Monkey") with sticky = true;  
        }
    }
}
