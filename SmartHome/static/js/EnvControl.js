//Flot Line Chart
// var EnvOutDoorUrl = "env/goOUT/"
// var EnvProtectUrl = "env/protect/"
// var EnvSleepUrl = "env/sleep/"
// var EnvWelcomeUr = "env/comHome/
var EnvUrlBase = "http://192.168.31.245:8000/api/env"

var Obj_EnvControl = {
    DOMList: [$('#btnEnvOutDoor'), $('#btnEnvProtect'), $('#btnEnvSleep')],
    EnvURL: ["goOUT", "protect", "sleep"],
    Commend: ["1", "1", "1"]
}

$(document).ready(function() {
    console.log("document ready");

     $.each(Obj_EnvControl.DOMList, function(i) {
        // console.log(i);
        Obj_EnvControl.DOMList[i].click(function(event) {

            var EnvUrl = EnvUrlBase + Obj_EnvControl.EnvURL[i] + "/";
            // console.log(EnvUrl);
            post_EnvControl(Obj_EnvControl.Commend[i], EnvUrl);
        });
    });

});


function post_EnvControl(EnvControlCommend, EnvControlUrl) {
    $.ajax({
        url: EnvControlUrl,
        headers: {
            "Content-Type": "application/json"
        },
        type: "PUT",
        data: EnvControlCommend,
        success: function(response) {
            console.log(response);

        },
        error: function(response) {
            console.log("error");
        }
    });

}
