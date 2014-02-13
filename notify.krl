ruleset a1299x176 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
    }
    dispatch {
        // domain "exampley.com"
    }
    rule rule_1_2 {
        select when pageview ".*" setting ()
        
        notify("Hello World", "This is a perminant notify.") with sticky = true;
        notify("Hello World Again!", "This is a second notify") with sticky = true;
    }
}
