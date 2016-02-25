var position = 0;
$(document).ready(function() {
    console.log("document ready");

    $("#ScrollUP").click(function(event) {
        position = position - 600;
        if (position < 0) {
            position == 0;
        }
        $('html, body').scrollTop(position);
    });

    $("#ScrollDOWN").click(function(event) {
        position = position + 500;

        $('html, body').scrollTop(position);
    });

});
