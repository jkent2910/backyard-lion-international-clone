/* Positions */

var archeryPositions = {"1": " "};

var badmintonPositions = {"1": " "};

var baseballPositions = { "0": "", "1": "Pitcher", "2": "Catcher", "3": "First Base", "4": "Second Base", "5": "ShortStop", "6": "Third Base", "7": "Left Field", "8": "Center Field", "9": "Right Field", "10": "Designated Hitter", "11": "Starting Pitcher", "12": "Relief Pitcher", "13": "Closer"};

var basketballPositions = { "0": "", "1": "Point Guard", "2": "Shooting Guard", "3": "Small Forward", "4": "Power Forward", "5": "Center"};

var bowlingPositions = { "0": "", "1": "Bowler" };

var cheerleadingPositions = { "0": "", "1": "Cheerleader", "2": "Dancer"};

var cricketPositions = { "0": "", "1": "Wicketkeeper", "2": "Slip", "3": "Gully", "4": "Point", "5": "Cover", "6": "Mid-off", "7": "Bowler", "8": "Mid-on", "9": "Mid-wicket", "10": "Fine leg", "11": "Third man", "12": "Batsman"};

var crosscountryPositions = { "0": "", "1": "5k"};

var equestrianridingPositions = { "1": " "};

var fencingPositions = { "1": " "};

var fishingPositions = { "1": " "};

var fieldhockeyPositions = { "0": "", "1": "Wing", "2": "Inner", "3": "Midfielder", "4": "Sweeper", "5": "Fullback", "6": "Goalie"};

var footballPositions = { "0": "", "1": "Quarterback", "2": "Running back", "3": "Wide receiver", "4": "Tight end", "5": "Center", "6": "Guard", "7": "Tackle", "8": "Defensive tackle", "9": "Defensive end", "10": "Linebacker", "11": "Cornerback", "12": "Safety", "13": "Kicker", "14": "Long snapper", "15": "Punter", "16": "Returner"};

var gymnasticsPositions = { "0": "", "1": "Pommel horse", "2": "Rings", "3": "Parallel bars", "4": "Floor", "5": "Vault", "6": "High bar"};

var golfPositions = { "1": " "};

var handballPositions = { "0": "", "1": "Goal keeper", "2": "Wing", "3": "Side", "4": "Pivot", "5": "Central"};

var icehockeyPositions = { "0": "", "1": "Winger", "2": "Center", "3": "Defenseman", "4": "Goaltender"};

var lacrossePositions = { "0": "", "1": "Attacker", "2": "Midfielder", "3": "Defender", "4": "Goalie"};

var motorsportsPositions = { "1": " "};

var riflePositions = { "1": " "};

var rodeoPositions = { "1": " "};

var rowingPositions = { "1": " "};

var rugbyPositions = { "0": "", "1": "1", "2": "2", "3": "3", "4": "4", "5": "5", "6": "6", "7": "7", "8": "8", "9": "9", "10": "10", "11": "11", "12": "12", "13": "13", "14": "14", "15": "15"};

var sailingPositions = { "1": " "};

var skiingPositions = { "1": " "};

var soccerPositions = { "0": "", "1": "Forward", "2": "Midfielder", "3": "Defender", "4": "Goal keeper"};

var squashPositions = { "1": " "};

var swimmingPositions = { "0": "", "1": "50 yard freestyle", "2": "100 yard freestyle", "3": "200 yard freestyle", "4": "500 yard freestyle", "5": "1,650 yard freestyle", "6": "100 yard backstroke", "7": "200 yard backstroke", "8": "100 yard breaststroke", "9": "200 yard breaststroke", "10": "100 yard butterfly", "11": "200 yard butterfly", "12": "One-meter dive", "13": "Three-meter dive", "14": "Platform dive"};

var tennisPositions = { "1": " "};

var trackandfieldPositions = { "0": "", "1": "Sprinter", "2": "Mid-Distance", "3": "Distance", "4": "Hurdler", "5": "Jumper", "6": "Thrower", "7": "Heptathlete", "8": "Decathlete"};

var volleyballPositions = { "0": "", "1": "Opposite", "2": "Middle blocker", "3": "Right side hitter", "4": "Setter", "5": "Libero", "6": "Outside hitter"};

var waterpoloPositions = { "0": "", "1": "Wing", "2": "Hole set", "3": "Flat", "4": "Point"};

var wrestlingPositions = { "0": "", "1": "103", "2": "112", "3": "119", "4": "125", "5": "130", "6": "135", "7": "140", "8": "145", "9": "152", "10": "160", "11": "171", "12": "189", "13": "215", "14": "285"};


function updatePositions(el, id, name) {

    var experience_id = id.split("-")[1];

    var parse_name = name.split('[');
    var get_number_portion = parse_name[2].slice(0,-1);

    var position_name_element = "athlete_profile[athlete_experiences_attributes][" + get_number_portion + "]" + "[primary_position]";
    var get_position_element = $('[name="' + position_name_element + '"]');
    updateDropdown(get_position_element, el);

    var second_position_name_element = "athlete_profile[athlete_experiences_attributes][" + get_number_portion + "]" + "[secondary_position]";
    var get_second_position_element = $('[name="' + second_position_name_element + '"]');

    updateDropdown(get_second_position_element, el);
}

function updatePositionsSearch(el, id) {

    $('#q_athlete_experiences_primary_position_cont').empty();
    updateDropdown('#q_athlete_experiences_primary_position_cont', el);
}

function updateTeamPositionsSearch(el, id) {

    $('#q_wanted_positions_position_id_eq').empty();
    updateDropdown('#q_wanted_positions_position_id_eq', el);
}


function updateDropdown(element_to_update, el) {
    $(element_to_update).empty();
    if (el == "Football (American)") {
        $.each(footballPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Baseball") {
        $.each(baseballPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Archery") {
        $.each(archeryPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Badminton") {
        $.each(badmintonPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Basketball (Female)") {
        $.each(basketballPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Basketball (Male)") {
        $.each(basketballPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Bowling (Female)") {
        $.each(bowlingPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Bowling (Male)") {
        $.each(bowlingPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Cheerleading") {
        $.each(cheerleadingPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Cricket") {
        $.each(cricketPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Cross Country (Female)") {
        $.each(crosscountryPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Cross Country (Male)") {
        $.each(crosscountryPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Equestrian-Riding") {
        $.each(equestrianridingPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Fencing") {
        $.each(fencingPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Field Hockey (Female)") {
        $.each(fieldhockeyPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Field Hockey (Male)") {
        $.each(fieldhockeyPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Fishing") {
        $.each(fishingPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Golf (Female)") {
        $.each(golfPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Golf (Male)") {
        $.each(golfPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Gymnastics") {
        $.each(gymnasticsPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Handball") {
        $.each(handballPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Golf (Female)") {
        $.each(golfPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Ice Hockey (Female)") {
        $.each(icehockeyPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Ice Hockey (Male)") {
        $.each(icehockeyPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Lacrosse (Female)") {
        $.each(lacrossePositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Lacrosse (Male)") {
        $.each(lacrossePositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Motorsports") {
        $.each(motorsportsPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Rifle (Female)") {
        $.each(riflePositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Rifle (Male)") {
        $.each(riflePositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Rodeo") {
        $.each(rodeoPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Rowing - Crew") {
        $.each(rowingPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Rugby") {
        $.each(rugbyPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Sailing") {
        $.each(sailingPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Skiing") {
        $.each(skiingPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Rifle (Female)") {
        $.each(riflePositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Soccer (Female)") {
        $.each(soccerPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Soccer (Male)") {
        $.each(soccerPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Softball") {
        $.each(baseballPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Squash (Female)") {
        $.each(squashPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Squash (Male)") {
        $.each(squashPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Swimming - Diving (Female)") {
        $.each(swimmingPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Swimming - Diving (Male)") {
        $.each(swimmingPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Tennis (Female)") {
        $.each(tennisPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Tennis (Male)") {
        $.each(tennisPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Track and Field (Female)") {
        $.each(trackandfieldPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Track and Field (Male)") {
        $.each(trackandfieldPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Volleyball (Female)") {
        $.each(volleyballPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Water Polo (Male)") {
        $.each(waterpoloPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    } else if (el == "Wrestling") {
        $.each(wrestlingPositions, function(key,value) {
            $(element_to_update).append($("<option/>", {
                value: value,
                text: value
            }));
        });
    }
}