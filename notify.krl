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
    		object = result.pick("$.content").decode();
    		object;
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
    
    rule clicked_rule_fail {
        select when web submit "#form" 
        pre {
        	moviesObject = findMovie(event:attr("movieTitle"));
        	count = moviesObject.pick("$.total");
        }
        if count eq 0 then {
        	replace_inner("#main", "<br>No Movie Found");
        }
        fired {
	       last
        }
    }
    
    rule clicked_rule {
        select when web submit "#form" 
        pre {
        	moviesObject = findMovie(event:attr("movieTitle"));
        	count = moviesObject.pick("$.total");
        	movieArray = moviesObject.pick("$.movies");
        	movieInfo = movieArray[0];
    		
        	
        	thumbnail = movieInfo.pick("$.posters").pick("$.thumbnail");
        	title = movieInfo.pick("$.title");
        	year = movieInfo.pick("$.year");
		synopsis = movieInfo.pick("$.synopsis");
		ratings = movieInfo.pick("$.ratings").pick("$.critics_score");
		ratings2 = movieInfo.pick("$.ratings").pick("$.critics_rating");
		
		out = "<img src=#{thumbnail}> <br>Title: #{title} <br>Year: #{year} <br>Critic Score: #{ratings} <br>Critic Rating: #{ratings2} <br>Synopsis: #{synopsis} " 
	
		
        }
        	if count > 0 then {
        	notify("Welcome!", movieInfo.as("str"));
        	notify("Success!", "Your Title " + event:attr("movieTitle") + " has been searched") with sticky = true;
		replace_inner("#main", out + "<br><br>info = " +  movieInfo.as("str") );
		}
        
        fired {
       		set ent:movieTitle event:attr("movieTitle");
        }
    }
}
