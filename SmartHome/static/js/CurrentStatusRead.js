//Flot Line Chart
var responseJson = [];
$(document).ready(function() {
    console.log("document ready");

    var nodeUrl = "http://192.168.1.215:8000/api/V1/node"
    $.ajax({
        url: nodeUrl,
        dataType: "json",
        success: function(response) {
            responseJson = response;
            console.log(responseJson);
        },
        error: function(response) {
            console.log("error");
        }
    });

});
