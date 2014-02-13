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
            notify("Hello World", "This is a perminant notify.") with sticky = true;
            notify("Hello World Again!", "This is a second notify");
        }
    }
    
   rule rule_2 {
        select when pageview ".*"
        pre {
            query = page:url("query");
            getName = function(string) {
                (string.extract(re/(?:name=)(\w*)/g)).join("")
            };
            name = getName(query);
            x = app:name + 1
        }
        //if ((not name eq "") && (x < 5)) then {
            notify("test", "Hello " + name);  
        //}
        fired {
            last
        }
    }
}
