// My Workspaces (Data Source) /////////////////////////////////////////////////////////////////////
var ds_authWorkspaces1 = {
    transport: {
        read: {
            url: "/workspace/myWorkspaces",
            dataType: "json",

            // additional parameters sent to the remote service
            data: {
            }
        }
    },
    schema: {
        // the data which the data source will be bound to is in the "results" field
        data: "items"
    }
};

var aRenderer = {
    openPage: function (path, hostDiv) {
        var itemSelector = '#' + hostDiv;
        $(itemSelector).children().remove();
        $.ajax({
            url: path,
            type: 'GET',
            dataType: 'html',
            success: function (result) {
                $(itemSelector).html(result);
            }
        });
    },

    openPage_w_jsonParam: function (path, param, hostDiv) {
    var itemSelector = '#' + hostDiv;
    $(itemSelector).children().remove();
    $.ajax({
        url: path,
        data: param,
        type: 'GET',
        dataType: 'html',
        success: function (result) {
            $(itemSelector).html(result);
        }
    });
}
}

// Query Definition in JSON
var jsonDataCaller = {
    syncCall: function(url, data) {
        return $.parseJSON($.ajax({
            type: "GET",
            dataType: "json",
            url: url,
            data: data,
            async: false
        }).responseText);
    }
}

//Show Progress
function showProgress(msg) {
    //Show the progress message to the user
    $("#innerMessage").html(msg);
    $("#loading").show();
};

//Hide Progress
function hideProgress() {
    //Processing is done so remove the progress message
    $("#innerMessage").html("&nbsp;");
    $("#loading").hide();
};

