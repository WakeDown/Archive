$(document).on('submit', 'form', function () {
    var button = $(this).find("[type='submit']");
    setTimeout(function () {
        button.prop('disabled', true);
        showSpinnerAppend(button);
    }, 0);

    //var button2 = $(this).find("button");
    //setTimeout(function () {
    //    button2.attr('disabled', 'disabled');
    //}, 0);
});

function showSpinner(obj, offset, offsetTop, offsetLeft) {
    var of = "";
    var stOf = "";
    if (offset) {
        of = "on-element";
        stOf = "top:" + offsetTop + "px;left:" + offsetLeft + "px";
    }
    var loading = "<div class='spinner active " + of + "' style='" + stOf + "'><i class='fa fa-spin fa-spinner'></i></div>";
    $(obj).before(loading);
}

function showSpinnerAfter(obj, offset, offsetTop, offsetLeft) {
    var of = "";
    var stOf = "";
    if (offset) {
        of = "on-element";
        stOf = "top:" + offsetTop + "px;left:" + offsetLeft + "px";
    }
    var loading = "<div class='spinner active " + of + "' style='" + stOf + "'><i class='fa fa-spin fa-spinner'></i></div>";
    $(obj).after(loading);
}

function showSpinnerAppend(obj, offset, offsetTop, offsetLeft) {
    var of = "";
    var stOf = "";
    if (offset) {
        of = "on-element";
        stOf = "top:" + offsetTop + "px;left:" + offsetLeft + "px";
    }
    var loading = "<div class='spinner active " + of + "' style='" + stOf + "'><i class='fa fa-spin fa-spinner'></i></div>";
    $(obj).prepend(loading);
}

function showSpinnerPrepend(obj, offset, offsetTop, offsetLeft) {
    var of = "";
    var stOf = "";
    if (offset) {
        of = "on-element";
        stOf = "top:" + offsetTop + "px;left:" + offsetLeft + "px";
    }
    var loading = "<div class='spinner active " + of + "' style='" + stOf + "'><i class='fa fa-spin fa-spinner'></i></div>";
    $(obj).prepend(loading);
}

function hideSpinner(obj) {
    if (obj) {
        $(obj).parent().find(".spinner.active").remove();
    } else {
        $(".spinner").remove();
    };
}