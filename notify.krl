ruleset a1299x176 {
    meta {
        name "Lab 2"
        author "Keith Halterman"
        logging off
    }
    dispatch {
    }
    global {
    	
    	key = "smgxpc6tvwsaufdtvtgr85ur";
    	
    	findMovie = function(title){
    		
    		result =  http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json", {"apikey":key, "q":title, "page_limit": 1});
    		body = result.pick("$.content").decode();
		movieArray = body.pick("$.movies");
		movie = movieArray[0];
    		notify("Welcome!", movie.as("str"));
    		movie
    		//"return"
    	}
    
    }
    
    rule show_form {
        select when pageview ".*"
        pre {
            form = <<
                <form id="form" onsubmit="return false">
                Movie Title: <input type="text" name="movieTitle"><br>
                <input type="submit" value="Submit">
                </form>
            >>;
        } 
        {
       
        notify("Welcome!", "Please enter a movie title") with sticky = true;
	replace_inner('#footer', form);
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
        	findMovie(movieTitle);
        	notify("Success!", "Your Title has been searched") with sticky = true;
		replace_inner("#main", "Searched " + event:attr("movieTitle"));
        }
        fired {
       		set ent:movieTitle event:attr("movieTitle");
        }
    }
}
