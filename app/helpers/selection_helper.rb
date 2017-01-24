module SelectionHelper

  def valid_countries
    ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua & Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia & Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon", "Canada", "Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador", "England", "Equatorial Guinea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre & Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","St Kitts & Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad & Tobago","Tunisia","Turkey","Turkmenistan","Turks & Caicos","Uganda","Ukraine","United Arab Emirates","United Kingdom", "United States", "Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe"]
  end

  def valid_languages
    ["Abkhazian", "Afar","Afrikaans","Albanian","Amharic","Arabic","Armenian","Assamese","Aymara","Azerbaijani","Bashkir","Basque","Bengali","Bhutani","Bihari","Bislama","Bosnian","Breton","Bulgarian",
	  "Burmese","Byelorussian","Cambodian","Catalan","Cherokee","Chewa","Chinese","Corsican","Croatian","Czech","Danish","Divehi","Dutch","Edo","English","Esperanto","Estonian","Faeroese","Farsi","Fiji","Finnish","Flemish","French","Frisian","Fulfulde","Gaelic","Galician","Georgian","German","Greek","Greenlandic","Guarani",
	  "Gujarati","Hausa","Hawaiian","Hebrew","Hindi","Hungarian","Ibibio","Icelandic","Igbo","Indonesian","Interlingua","Interlingue","Inuktitut","Inupiak","Irish","Italian","Japanese","Javanese","Kannada","Kanuri","Kashmiri","Kazakh","Kinyarwanda","Kirghiz","Kirundi","Konkani","Korean","Kurdish","Laothian","Latin","Latvian","Limburgish","Lingala",
    "Lithuanian","Macedonian","Malagasy","Malay","Malayalam","Maltese","Maori","Marathi","Moldavian","Mongolian","Nauru","Nepali","Norwegian","Occitan","Oriya","Oromo","Papiamentu","Pashto","Polish","Portuguese","Punjabi","Quechua","Romanian","Russian","Sami","Samoan","Sangro","Sanskrit","Serbian","Serbo-Croatian","Sesotho","Setswana","Shona","Sindhi","Sinhalese",
    "Siswati","Slovak","Slovenian","Somali","Spanish","Sundanese","Swahili","Swedish","Syriac","Tagalog","Tajik","Tamazight","Tamil","Tatar","Telugu","Thai","Tibetan","Tigrinya","Tonga","Tsonga","Turkish","Turkmen","Twi","Uighur","Ukrainian","Urdu","Uzbek","Venda","Vietnamese","Volap","Welsh","Wolof","Xhosa","Yi","Yiddish","Yoruba","Zulu"]
  end

  def benefit_ratings
    ["yes", "preferred", "no"]
  end

  def position_priorities
    ["high", "medium", "low"]
  end

  def valid_sports
    ["Baseball", "Basketball (Female)", "Basketball (Male)",
     "Cross Country (Female)", "Cross Country (Male)", "Field Hockey",
     "Football (American)", "Golf (Female)", "Golf (Male)", "Rifle (Female)", "Rifle (Male)", "Gymnastics", "Ice Hockey",
     "Lacrosse", "Rowing", "Soccer (Female)", "Soccer (Male)", "Softball", "Swimming and Diving", "Tennis (Female)",
     "Tennis (Male)", "Track and Field (Female)", "Track and Field (Male)", "Volleyball (Female)",
     "Volleyball (Male)", "Wrestling"]
  end

  def sport_positions
    ["Pitcher", "Catcher", "First Base", "Second Base", "ShortStop", "Third Base", "Left Field", "Center Field", "Right Field", "Designated Hitter", "Starting Pitcher", "Relief Pitcher", "Closer",
     "Point Guard", "Shooting Guard", "Small Forward", "Power Forward", "Center", "Bowler", "Cheerleader", "Dancer", "Wicketkeeper", "Slip", "Gully", "Point", "Cover", "Mid-off", "Mid-on", "Mid-wicket",
     "Fine leg", "Third man", "Batsman", "5k", "Wing", "Inner", "Midfielder", "Sweeper", "Fullback", "Goalie", "Quarterback", "Running back", "Wide receiver", "Tight end", "Center", "Guard", "Tackle", "Defensive end", "Linebacker",
     "Cornerback", "Safety", "Kicker", "Long snapper", "Punter", "Returner", "Pommel horse", "Rings", "Parallel bars", "Floor", "Vault", "High bar", "Goal keeper", "Wing", "Side", "Pivot", "Central", "Winger", "Center",
     "Defenseman", "Goaltender", "Attacker", "Defender", "Goalie", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "Forward", "Goal keeper", "50 yard freestyle",
     "100 yard freestyle", "200 yard freestyle", "500 yard freestyle", "1,650 yard freestyle", "100 yard backstroke", "200 yard backstroke", "100 yard breaststroke", "200 yard breaststroke", "100 yard butterfly", "200 yard butterfly",
     "One-meter dive", "Three-meter dive", "Platform dive", "60 m", "100 m", "200 m", "400 m", "800 m", "1500 m", "1600 m", "3000 m", "3200 m","5000 m", "10,000 m", "60 m hurdles", "100 m hurdles", "110 m hurdles",
     "400 m hurdles", "Long jump", "Triple jump", "High jump", "Pole vault", "Shot put", "Discus", "Hammer", "Javelin", "Pentathlon", "Heptathlon", "Decathlon", "Opposite", "Middle blocker", "Right side hitter", "Setter", "Libero", "Outside hitter",
     "Wing", "Hole set", "Flat", "Point", "103", "112", "119", "125", "130", "135", "140", "145", "152", "160", "171", "189", "215", "285"]
  end

  def level_of_play
    ["Canada: CFL", "Canada: CIS", "Canada: Junior", "Europe: 1st Division", "Europe: 2nd Division", "Europe: 3rd Division", "Europe: Regional", "Other",
     "Quebec: Collegial Div 1", "Quebec: Collegial Div 2", "Quebec: Collegial Div 3", "Semi-Pro", "USA: Arena Football", "USA: Division II", "USA: Division III",
     "USA: FBS (Division I-A)", "USA: FCS (Division I-AA", "USA: JUCO", "USA: NAIA", "USA: NFL", "USA: MLB", "USA: NBA", "High School"]
  end

  def valid_salaries
    ["Negotiable", "Less than 500 euros/month", "501-1,000 euros/month", "1,001-1,500 euros/month", "1,501-2,000 euros/month", "More than 2,000 euros/month"]
  end

  def valid_relationships
    ["Teammate", "Opposing Player", "Coach", "Opposing Coach", "Trainer", "Teacher", "Guidance Councelor", "Mentor", "Supporter"]
  end

  def units
    ["Pounds", "Kilograms", "Seconds", "Minutes", "Inches", "Feet", "Yards", "Meters", "Miles", "Kilometers", "Reptitions", "Points", "MPH"]
  end

  def skills
    ["Bench Press", "Squat", "Clean", "Deadlift", "RDL", "225 reps", "Vertical Jump", "Broad Jump", "10 Yard Dash", "40 Yard Dash", "3 Cone Drill", "Shuttle Run(5-10-5)", "Pop time", "Pitching Speed", "Home to First", "60 m", "100 m", "200 m", "400 m", "800 m", "1500 m", "1600 m", "3000 m", "3200 m", "5000 m", "10,000 m", "60 m hurdles", "100 m hurdles", "110 m hurdles", "400 m hurdles", "Long jump", "Triple jump", "High jump", "Pole vault", "Shot put", "Discus", "Hammer", "Javelin", "Pentathlon",
     "Heptathlon", "Decathlon", "50 yard freestyle", "100 yard freestyle", "200 yard freestyle", "500 yard freestyle", "1,650 yard freestyle", "100 yard backstroke", "200 yard backstroke", "100 yard breaststroke", "200 yard breaststroke", "100 yard butterfly", "200 yard butterfly", "One-meter dive", "Three-meter dive", "Platform dive", "Forward Sprint (90ft)", " Backward Sprint (90ft)", "Forward Agility Sprint (90ft)", "Forward Agility Sprint with Puck (90)", "Shot Speed", "Serve Speed", "Rowing 2k"]
  end
end