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
            notify("Part 3", "Hello " + query); 
        //    getName = function(string) {
        //        (string.extract(re/(?:name=)(\w*)/g)).join("")
         //   };
         //   name = getName(query);
         //   x = app:name + 1
        }
        //if ((not name eq "") && (x < 5)) then {
         //   notify("Part 3", "Hello " + query);  
        //}
        //else {
         //   notify("Part 3", "Hello Monkey");
        //}
        
    //    fired {
     //       last
      //  }
    }
}
