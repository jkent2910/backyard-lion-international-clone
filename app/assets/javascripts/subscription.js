/**
 * Created by devanmoylan on 12/15/16.
 */

/** .js to show / hide the payment plans based on level **/
$(document).ready(function() {
    if (window.location.href.indexOf('=platinum') > -1) {
        $('.byl-platinum').show();
        $('.byl-gold').hide();
        $('.byl-silver').hide();
    }
    else if (window.location.href.indexOf('=gold') > -1) {
        $('.byl-silver').hide();
        $('.byl-platinum').hide();
        $('.byl-gold').show();
    }
    else if (window.location.href.indexOf('=silver') > -1) {
        $('.byl-platinum').hide();
        $('.byl-gold').hide();
        $('.byl-silver').show();
    }

// this is for the platinum membership
    $('.platinum-short-list-btn-yes').click(function() {
        if ($('#platinum-yes').css('display') == 'none') {
            $('#platinum-yes').show();
            $('#platinum-no').hide();
        } else if ($('#platinum-no').css('display') == 'none') {
            $('#platinum-yes').show();
            $('#platinum-no').hide();
        }
    });

    $('.platinum-short-list-btn-no').click(function() {
        if ($('#platinum-no').css('display') == 'none') {
            $('#platinum-yes').hide();
            $('#platinum-no').show();
        } else if ($('#platinum-no').css('display') == 'none') {
            $('#platinum-yes').show();
            $('#platinum-no').hide();
        }
    });

});


