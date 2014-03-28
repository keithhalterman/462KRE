//b505690x1.dev
//Account 1: 068DF654-AFB9-11E3-8620-ECF8637EDFE5
//Account 2: 11DED720-B433-11E3-81D5-BFDA283232C8
//Account 3: 05629D2E-B433-11E3-9A1E-8283E71C24E1

// http://raw.github.com/keithhalterman/462KRE/master/Lab8/MultiFourSquare.krl

//Account 1: b505690x16
//Account 2: b505832x0
//Account 3: b505834x0

ruleset MultiFourSquare{ 
  meta {
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
    use module b505690x6 alias Location
    use module b505690x14 alias textSender
  }
  
 
 rule view {
    select when pageview ".*"
    {
    notify("Is this working?","yes");
    }
  }

    
}

