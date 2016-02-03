//Flot Line Chart
var responseJson = [];

$(document).ready(function() {
    console.log("document ready");
    var responseJson = [];
    // 按下按鍵，REST GET要資料，檢查開關狀態
    // N type
    $('#btnMainLight').click(function() {
        var nodeUrl = "http://192.168.31.168:8000/api/V1/node/4/"
        $.ajax({
            url: nodeUrl,
            dataType: "json",
            success: function(response) {
                responseJson = response;
                console.log(responseJson);
                checkNodeNState(responseJson.State, nodeUrl);
            },
            error: function(response) {
                console.log("error");
            }
        });
    });

    $('#btnWallLight').click(function() {
        var nodeUrl = "http://192.168.31.168:8000/api/V1/node/5/"
        $.ajax({
            url: nodeUrl,
            dataType: "json",
            success: function(response) {
                responseJson = response;
                console.log(responseJson);
                checkNodeNState(responseJson.State, nodeUrl);
            },
            error: function(response) {
                console.log("error");
            }
        });
    });

    $('#btnFan').click(function() {
        var nodeUrl = "http://192.168.31.168:8000/api/V1/node/6/"
        $.ajax({
            url: nodeUrl,
            dataType: "json",
            success: function(response) {
                responseJson = response;
                console.log(responseJson);
                checkNodeNState(responseJson.State, nodeUrl);
            },
            error: function(response) {
                console.log("error");
            }
        });
    });

    // 按下按鍵，REST GET要資料，檢查開關狀態
    // N type
    $('#btnCurtain1').click(function() {
        var nodeUrl = "http://192.168.31.168:8000/api/V1/node/8/"
        $.ajax({
            url: nodeUrl,
            dataType: "json",
            success: function(response) {
                responseJson = response;
                console.log(responseJson);
                checkNodeLState(responseJson.State, nodeUrl, 1);
            },
            error: function(response) {
                console.log("error");
            }
        });
    });

    $('#btnCurtain2').click(function() {
        var nodeUrl = "http://192.168.31.168:8000/api/V1/node/8/"
        $.ajax({
            url: nodeUrl,
            dataType: "json",
            success: function(response) {
                responseJson = response;
                console.log(responseJson);
                checkNodeLState(responseJson.State, nodeUrl, 2);
            },
            error: function(response) {
                console.log("error");
            }
        });
    });

    $('#btnCurtain3').click(function() {
        var nodeUrl = "http://192.168.31.168:8000/api/V1/node/8/"
        $.ajax({
            url: nodeUrl,
            dataType: "json",
            success: function(response) {
                responseJson = response;
                console.log(responseJson);
                checkNodeLState(responseJson.State, nodeUrl, 3);
            },
            error: function(response) {
                console.log("error");
            }
        });
    });

    // // IR
    // $('#btnTVON').click(function() {
    //     var nodeUrl = "http://192.168.31.168:8000/api/V1/node/9/"
    //     checkNodeIRState("ON", nodeUrl)
    // });
    // $('#btnTVMute').click(function() {
    //     var nodeUrl = "http://192.168.31.168:8000/api/V1/node/9/"
    //     checkNodeIRState("Mute", nodeUrl)
    // });
    // $('#btnTVUP').click(function() {
    //     var nodeUrl = "http://192.168.31.168:8000/api/V1/node/9/"
    //     checkNodeIRState("UP", nodeUrl)
    // });

});

// no use
function getNodeState(nodeurl) {

    $.ajax({
        url: nodeurl,
        type: "GET",
        success: function(response) {
            console.log(response);
            return response;
        },
        error: function(response) {
            console.log("error");
        }
    });
}

// check node status
function checkNodeNState(State, nodeUrl) {
    var open = '{"State": 1}';
    var close = '{"State": 0}';
    // ON status --> close
    if (State == 1) {
        nodeChangeState(close, nodeUrl)
    } else {
        nodeChangeState(open, nodeUrl)
    }

}

function checkNodeLState(State, nodeUrl, nodeOrder) {
    // chech data
    State = parseInt(State);
    if (nodeOrder == 3) {
        // node 3 = HIGH 1XX
        if (State > 3) {
            State = State - 4;
        } else {
            State = State + 4;
        }
    } else if (nodeOrder == 2) {
        if (State == 2 || State == 3 || State == 6 || State == 7) {
            State = State - 2;
        } else {
            State = State + 2;
        }
    } else {
        if (State == 1 || State == 3 || State == 5 || State == 7) {
            State = State - 1;
        } else {
            State = State + 1;
        }
    }
    State = State.toString();

    var sendStatus = '{"State": ';
    sendStatus = sendStatus + State + '}';

    console.log(sendStatus);
    // ON status --> close
    nodeChangeState(sendStatus, nodeUrl)
}

function checkNodeIRState(State, nodeUrl) {
    var sendStatus = '{"State": "';
    sendStatus = sendStatus + State + '"}';

    console.log(sendStatus);
    // ON status --> close
    nodeChangeState(sendStatus, nodeUrl)

}

//改變開關狀態 REST PUT 改變狀態 
function nodeChangeState(inputStatus, nodeurl) {
    $.ajax({
        url: nodeurl,
        headers: {
            "Content-Type": "application/json"
        },
        type: "PUT",
        data: inputStatus,
        success: function(response) {
            console.log(response);
        },
        error: function(response) {
            console.log("error");
        }
    });
}
