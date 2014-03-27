//Account 1: 068DF654-AFB9-11E3-8620-ECF8637EDFE5
//Account 2: 11DED720-B433-11E3-81D5-BFDA283232C8
//Account 3: 05629D2E-B433-11E3-9A1E-8283E71C24E1

ruleset MultiFourSquare{ 
  meta {
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
    use module b505690x6 alias Location
    use module b505690x14 alias textSender
  }
  global{
    subscription_map =
    {
    "cid":"068DF654-AFB9-11E3-8620-ECF8637EDFE5"
    };
  }
}
