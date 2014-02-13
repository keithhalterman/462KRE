ruleset a1299x176 {
    meta {
        name "Lab 2"
        author "Keith Halterman"
        logging off
    }
    dispatch {
    }
    
    rule rule_1_2 {
        select when pageview ".*" {
            notify("Hello World", "This is a perminant notify.") with sticky = true;
            notify("Hello World Again!", "This is a second notify");
        }
    }
    
    rule rule_3 {
        pre {
          query = page:url("query");
        }
        
        notify("Hello", "query") with position = bottom-left;
        
    }
}
