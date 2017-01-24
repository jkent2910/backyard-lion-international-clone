// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require html.sortable
//= require jquery-ui
//= require chosen-jquery
//= require bootstrap-sprockets
//= require cocoon
//= require teams
//= require star-rating
//= require athlete_profiles
//= require subscription

$(document).ready(function() {


    // this is for the conversations stuff
    $('.send-new-msg-btn').click(function() {

        if ($('#show_conversation').css('display') == 'none') {
            $('#show_conversation').show();
            $('#show_new_message').hide();
        } else {
            $('#show_conversation').hide();
            $('#show_new_message').show();
        }
    });

    // this is for the users/:id/new_team page validation
    $('.new-team-btn').click(function() {
        if ($('#user_team_id').val().length == 0 || $('#team_website_url').val().length == 0) {
            alert("You must fill out all fields to continue");
        }
    });

    // This handles the ranking of athletes on the team side of the application
    set_positions();
    $('.sortable').sortable();

    $('.sortable').sortable().bind('sortupdate', function(e, ui) {
        updated_order = [];

        set_positions();

        $('.panel.panel-default').each(function(i){
            updated_order.push({id: $(this).data("id"), position: i+1});
        });

        $.ajax({
            type: "PUT",
            url: '/users/sort',
            data: { order: updated_order }
        });
    });

    // This handles the ranking of teams on the athlete_profiles side of the application
    $('.team-sortable').sortable();
    $('.team-sortable').sortable().bind('sortupdate', function(e, ui) {
        updated_order = [];

        set_positions();

        $('.panel.panel-default').each(function(i) {
            updated_order.push({id: $(this).data("id"), position: i+1});
        });

        $.ajax({
            type: "PUT",
            url: '/teams/sort',
            data: { order: updated_order}
        });
    });


    // This function is for the initial athlete_profiles sign-up flow
	register_progressive_profiling_clicks();

    // This initializes the chosen-dropdown for messages
    $('.chosen-it').chosen();


    // This handles the star ratings
    $(".rating").rating({showCaption: false, showClear: false});

    $('.rating').on('rating.change', function(event, value, caption) {

        $.ajax({
            type: "POST",
            url: "/athlete_profiles/" + this.getAttribute("data") + "/register_star_rating",
            data: {
                id: (this.getAttribute("data")),
                rating: value,
                user_id: this.getAttribute("user_id")
            }
        }).done(function() {
            // Nothing for now
            var width;
            if (value == 0.5) {
                width = "10%";
            } else if (value == 1) {
                width = "20%";
            } else if (value == 1.5) {
                width = "30%";
            } else if (value == 2) {
                width = "40%";
            } else if (value == 2.5) {
                width = "50%";
            } else if (value == 3) {
                width = "60%";
            } else if (value == 3.5) {
                width = "70%";
            } else if (value == 4) {
                width = "80%";
            } else if (value == 4.5) {
                width = "90%";
            } else if (value == 5) {
                width = "100%";
            }
        })
    });

    if (window.location.href.indexOf("saved_athletes") > -1) {

    } else {
        set_star_ratings();
    }
});


// This is related to the ranking/sorting
set_positions = function() {
    $('.panel.panel-default').each(function(i){
        $(this).attr("data-pos", i+1);
    });
};

// This function figures out if the user has rated the athlete, and if so, fills in the right number of stars
function set_star_ratings() {
    // Grab one of the star elements so we can get the athlete_profile and user_id attributes
    var star = $('.rating-attributes')[0];

    if (star == undefined) {

    } else {

        $.ajax({
            type: "POST",
            url: "/athlete_profiles/" + star.getAttribute("data") + "/check_ratings",
            data: {
                athlete_profile: star.getAttribute("data"),
                user_id: star.getAttribute("user_id")
            },
            success: function (result) {
                // Nothing for now
                var width;
                if (result == 0.5) {
                    width = "10%";
                } else if (result == 1) {
                    width = "20%";
                } else if (result == 1.5) {
                    width = "30%";
                } else if (result == 2) {
                    width = "40%";
                } else if (result == 2.5) {
                    width = "50%";
                } else if (result == 3) {
                    width = "60%";
                } else if (result == 3.5) {
                    width = "70%";
                } else if (result == 4) {
                    width = "80%";
                } else if (result == 4.5) {
                    width = "90%";
                } else if (result == 5) {
                    width = "100%";
                }
                $('.filled-stars').width(width)
            }
        }).done(function () {
            // Maybe do something here sometime.
        });
    }
}

function register_progressive_profiling_clicks() {

    $('#step-one').click(function () {

        if (!$("input[name='athlete_profile[gender]']:checked").val()) {
            alert("You must enter all fields to continue")
        } else {
            $('.profile-step-one').hide();
            $('#step-one').hide();
            $('.profile-step-two').show();
            $('#step-two').show();
            window.history.pushState(null, null, '?step_two')
        }
    });

    $('#step-two').click(function() {

            $('.profile-step-two').hide();
            $('#step-two').hide();
            $('.profile-step-three').show();
            $('#step-three').show();
            window.history.pushState(null, null, '?step_three')
        
    });

    $('#step-three').click(function() {

        if ($('#athlete_profile_first_language').val().length == 0 || $('#athlete_profile_primary_citizenship').val().length == 0) {
            alert("You must enter a primary language and a primary citizenship to continue")
        } else {
            $('.profile-step-three').hide();
            $('#step-three').hide();
            $('.profile-step-four').show();
            $('#step-four').show();
            window.history.pushState(null, null, '?step_four')
        }

    });

    $('#step-four').click(function() {
        $('.profile-step-four').hide();
        $('#step-four').hide();
        $('.profile-step-five').show();
        $('#step-five').show();
        window.history.pushState(null, null, '?step_five')
    });

    $('#step-five').click(function() {
 
            $('.profile-step-five').hide();
            $('#step-five').hide();
            $('.profile-step-six').show();
            $('.submit-create').show();

            window.history.pushState(null, null, '?step_six')
            $('.btn-success.add_fields').click()
        
    });

    $('#step-six').click(function() {


            $('.profile-step-six').hide();
            $('#step-six').hide();
            $('.profile-step-seven').show();
            $('#step-seven').show();
            window.history.pushState(null, null, '?step_seven')
        
    });
    
    $('#start-over').click(function() {
        location.reload();
    });
}

function trackClick(count, id) {
    if (count >= 1) {
        $('.green-circle').hide();
        $.ajax({
            type: "POST",
            url: "/athlete_profiles/update_notifications",
            data: {id: id }
        })
    }
}

function trackTeamClick(count, id) {
    if (count >= 1) {
        $('.green-circle').hide();
        $.ajax({
            type: "POST",
            url: "/teams/update_notifications",
            data: {id: id }
        })
    }
}