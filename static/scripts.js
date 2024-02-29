// static/script.js
$(document).ready(function() {
    $('.star').on('click', function() {
        var value = $(this).data('value');
        var parentDivId = $(this).parent().attr('id');
        $('#' + parentDivId + '-rating-value').val(value);
        $('.star', '#' + parentDivId).each(function() {
            if ($(this).data('value') <= value) {
                $(this).css('color', '#ff9900');
            } else {
                $(this).css('color', '#ffc107');
            }
        });
    });

    // Reset rating when clicked again
    $('.star').on('click', function() {
        var value = $(this).data('value');
        var parentDivId = $(this).parent().attr('id');
        if ($('#' + parentDivId + '-rating-value').val() == value) {
            $('#' + parentDivId + '-rating-value').val('');
            $('.star', '#' + parentDivId).css('color', '#ffc107');
        }
    });
});
