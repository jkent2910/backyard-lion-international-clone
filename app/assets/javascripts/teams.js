function registerInterest(element) {
    $.ajax({
        type: "POST",
        url: "/athlete_profiles/" + element.getAttribute("athlete_profile") + "/express_interest",
        data: {
            team_id: (element.getAttribute("data")),
            athlete_profile: (element.getAttribute("athlete_profile"))
        }
    }).done(function() {
        $(element).removeClass('btn-success');
        $(element).html("<span style='color:lightgray;'><i class='fa fa-times'></i> remove</span>");
        $(element).attr('onclick', 'removeInterest(this)');
    });
}

function removeInterest(element) {
    $.ajax({
        type: "POST",
        url: "/athlete_profiles/" + element.getAttribute("athlete_profile") + "/remove_interest",
        data: {
            team_id: (element.getAttribute("data")),
            athlete_profile: (element.getAttribute("athlete_profile"))
        }
    }).done(function() {
        $(element).removeClass('btn-danger');
        $(element).html("<i class='fa fa-plus'></i>");
        $(element).attr('onclick', 'registerInterest(this)');
    });
}

function removeAthlete(element) {
    $.ajax({
        type: "POST",
        url: "/users/" + element.getAttribute("data") + "/unsave_athlete",
        data: {
            user_id: (element.getAttribute("data")),
            athlete_profile: (element.getAttribute("athlete_profile_id"))
        }
    }).done(function() {
        $(element).removeClass('btn-danger');
        $(element).html("<i class='fa fa-plus'></i>");
        $(element).attr('onclick', 'saveAthlete(this)');
    });
}

function saveAthlete(element) {
    $.ajax({
        type: "POST",
        url: "/users/" + element.getAttribute("data") + "/save_athlete",
        data: {
            user_id: (element.getAttribute("data")),
            athlete_profile: (element.getAttribute("athlete_profile_id"))
        }
    }).done(function() {
        $(element).removeClass('btn-danger');
        $(element).html("<span style='color:lightgray;'><i class='fa fa-times'></i> remove</span>");
        $(element).attr('onclick', 'removeAthlete(this)');
    });
}

function removeWantedPosition(element) {
    $.ajax({
        type: "PATCH",
        url: "/teams/" + element.getAttribute("team_id") + "/remove_wanted_position",
        data: {
            team_id: (element.getAttribute("team_id")),
            wanted_position_id: (element.getAttribute("data"))
        }
    });
}

function updateTeams(element) {
    var country = $(element).find(":selected").text();

    $.ajax({
        type: "POST",
        url: "/teams/get_teams",
        data: {
            country: country
        },
        success: function(result) {
            $('.teams-dropdown').empty();

            $.each(result, function(index, value) {
                $('.teams-dropdown').append($("<option/>", {
                    value: value["id"],
                    text: value["team_name"]
                }));
            });

            $('.teams-dropdown').append($("<option />", {
                value: "Other",
                text: "Other"
            }));
        }
    });
}