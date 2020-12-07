//----------------------------------------------------REGION DEDUCTIONS------------------------------------------------------------


//----Clearing Deducted Item Field-----
$("#btn-clearDeductions").click(function () {
    fnResetTbltxt1();
});

//----Reset Bulk Insert Table Data----
function fnResetTbltxt1() {
    $("#deductions").val("");
    $("#deductions").trigger("chosen:updated");

    $("#deducted-amount").val("");
}


//-----Deleting Earnings Item-----
function DeleteDeductedItem(ele) {
    var name = ele.name;
    var TblLen = $("#tblDeduction tr:gt(0)").length;
    bootbox.confirm({
        message: " Are you sure to delete?",
        buttons: {
            'confirm': {
                label: 'Yes',
                className: 'btn-danger'
            },
            'cancel': {
                label: 'Cancel',
                className: 'btn-default'
            }
        },
        callback: function (result) {
            if (result == true) {
                if (name == TblLen) {
                    ele.closest('tr').remove();
                }
                else {
                    ele.closest('tr').remove();
                    var i = name;
                    var n = name;
                    while (i <= TblLen) {
                        i++;

                        $("#deductedId_" + (i)).attr('name', 'deductionsListPart[' + (name) + '].ItemId');
                        $("#deductedId_" + (i)).attr('id', 'deductedId_' + (name));

                        $("#deductedRate_" + (i)).attr('name', 'deductionsListPart[' + (name) + '].Rate');
                        $("#deductedRate_" + (i)).attr('id', 'deductedRate_' + (name));

                        name++;

                        $("#deductedId_" + n).closest('tr').find('.button').attr('name', n);
                        n++;
                    }
                }
            }

        }
    });

}


//---Updating Edit Bulk Insert Item--
function UpdateDeductionRow(ele) {
    var R = ele.name;
    debugger
    $("#row_d" + R).html(TblTd1(R));
    $("#DeductionEditBtn").hide();
    $("#btn-AddDeduction").show();
    $("#btn-clearDeductions").show();

    $("#DeductionEditBtn").attr('name', "DeductionEditBtn");
    $("#row_d" + R).show();
    $("[id^=editPo1_]").prop("disabled", false);

    fnResetTbltxt1();
}


//---Editing Append Data for Bulk Insert View-----
function EditDeductedList(ele) {
    
    $("#DeductionEditBtn").show();
    $("#btn-AddDeduction").hide();
    $("#btn-clearDeductions").hide();

    var index = ele.name;
    $("#row_d" + index).hide();
    var itemId = $("#deductedId_" + index).val();
    var rate = $("#deductedRate_" + index).val();

    $("#deductions").val(itemId);
    $("#deducted-amount").val(rate);
    $("#DeductionEditBtn").attr('name', index);
    $("#deductions").trigger("chosen:updated");
    $("[id^=editPo1_]").prop("disabled", "disabled");
}

function TblTd1(R) {
    var Name = "deductionsListPart[" + R + "]";

    var itemName = $('#deductions :Selected').text();
    var rate = $('#deducted-amount').val();
    var itemId = $('#deductions').val();

    var primaryRow = '<td>'
        + fnAddHdn(Name + ".ItemId", itemId, "deductedId_" + R) + itemName + '</td><td>'
        + fnAddHdn(Name + ".Rate", rate, "deductedRate_" + R) + rate + '</td>'

    var delBtn = '<td><button type="button" onclick="DeleteDeductedItem(this)" rel="tooltip" title="Delete Row" class="button" name="' + R + '"><i class="fa fa-trash"></i></button>'
    var editBtn = ' <button id="editPo1_' + itemId + '" type="button" onclick="EditDeductedList(this)" rel="tooltip" title="Edit Row" class="button" name="' + R + '"><i class="fa fa-edit"></i></button></td>'

    var tdCollection = primaryRow + delBtn + editBtn;
    return tdCollection;
}

$('#btn-AddDeduction').on('click', function () {
    var ValidId = $('#deductions').val();
    var ValidRate = $('#deducted-amount').val();

    var msg = "";
    var count = 0;
    if (ValidId == "") {
        $('#deductions').css('border-color', 'red');

        msg = "Deductions is required."
        count++;
    }
    else {
        $('#deductions').css('border-color', '');
    }


    if (ValidRate == "") {
        $('#deducted-amount').css('border-color', 'red');

        msg = msg + " Deducted Rate is Required."
        count++;
    }
    else {
        $('#deducted-amount').css('border-color', '');
    }

    if (count > 0) {
        GlobalFunctions.GetMessage(msg, null, 0, 0, null, null);
        return;
    }
    var R = $("#tblDeduction tr:gt(0)").length;
    R = R - 1;
    $("#tblDeduction tbody tr:first").after('<tr id="row_d' + R + '">' + TblTd1(R) + '</tr>');
    fnResetTbltxt1();

});



//----------------------------------------------------REGION EARNINGS------------------------------------------------------------

//----Clearing Earnings Item Field-----
$("#btn-clearEarnings").click(function () {
    fnResetTbltxt();
});

//----Reset Bulk Insert Table Data----
function fnResetTbltxt() {
    $("#earning").val("");
    $("#earning").trigger("chosen:updated");

    $("#earning-amount").val("");
}

//-----Deleting Earnings Item-----
function DeleteEarningsItem(ele) {
    var name = ele.name;
    var TblLen = $("#tblEarnings tr:gt(0)").length;
    bootbox.confirm({
        message: " Are you sure to delete?",
        buttons: {
            'confirm': {
                label: 'Yes',
                className: 'btn-danger'
            },
            'cancel': {
                label: 'Cancel',
                className: 'btn-default'
            }
        },
        callback: function (result) {
            if (result == true) {
                if (name == TblLen) {
                    ele.closest('tr').remove();
                }
                else {
                    ele.closest('tr').remove();
                    var i = name;
                    var n = name;
                    while (i <= TblLen) {
                        i++;

                        $("#ItemId_" + (i)).attr('name', 'earningsListPart[' + (name) + '].ItemId');
                        $("#ItemId_" + (i)).attr('id', 'ItemId_' + (name));

                        $("#Rate_" + (i)).attr('name', 'earningsListPart[' + (name) + '].Rate');
                        $("#Rate_" + (i)).attr('id', 'Rate_' + (name));

                        name++;

                        $("#ItemId_" + n).closest('tr').find('.button').attr('name', n);
                        n++;
                    }
                }
            }

        }
    });

}

//----Hidden Field for bulk Insert-----
function fnAddHdn(Name, value, Id) {

    var hdn = "<input type='hidden' name='" + Name + "' value='" + value + "' id='" + Id + "' />";
    return hdn;
}

//---Updating Edit Bulk Insert Item--
function UpdateEarningRow(ele) {
    var R = ele.name;

    $("#row" + R).html(TblTd(R));
    $("#EarningEditBtn").hide();
    $("#btn-AddEarning").show();
    $("#btn-clearEarnings").show();

    $("#EarningEditBtn").attr('name', "EarningEditBtn");
    $("#row" + R).show();
    $("[id^=editPo_]").prop("disabled", false);

    fnResetTbltxt();
}
//---Editing Append Data for Bulk Insert View-----
function EditEarningList(ele) {
    
    $("#EarningEditBtn").show();
    $("#btn-AddEarning").hide();
    $("#btn-clearEarnings").hide();

    var index = ele.name;
    $("#row" + index).hide();
    var itemId = $("#ItemId_" + index).val();
    var rate = $("#Rate_" + index).val();

    $("#earning").val(itemId);
    $("#earning-amount").val(rate);
    $("#EarningEditBtn").attr('name', index);
    $("#earning").trigger("chosen:updated");
    $("[id^=editPo_]").prop("disabled", "disabled");

}

function TblTd(R) {

    var Name = "earningsListPart[" + R + "]";

    var itemName = $('#earning :Selected').text();
    var rate = $('#earning-amount').val();
    var itemId = $('#earning').val();

    var primaryRow = '<td>'
        + fnAddHdn(Name + ".ItemId", itemId, "ItemId_" + R) + itemName + '</td><td>'
        + fnAddHdn(Name + ".Rate", rate, "Rate_" + R) + rate + '</td>'

    var delBtn = '<td><button type="button" onclick="DeleteEarningsItem(this)" rel="tooltip" title="Delete Row" class="button" name="' + R + '"><i class="fa fa-trash"></i></button>'
    var editBtn = ' <button id="editPo_' + itemId + '" type="button" onclick="EditEarningList(this)" rel="tooltip" title="Edit Row" class="button" name="' + R + '"><i class="fa fa-edit"></i></button></td>'

    var tdCollection = primaryRow + delBtn + editBtn;
    return tdCollection;
}

$('#btn-AddEarning').on('click', function () {
    var ValidEarningId = $('#earning').val();
    var ValidEarningRate = $('#earning-amount').val();

    var msg = "";
    var count = 0;
    if (ValidEarningId == "") {
        $('#earning').css('border-color', 'red');

        msg = "Earning is required."
        count++;
    }
    else {
        $('#earning').css('border-color', '');
    }


    if (ValidEarningRate == "") {
        $('#earning-amount').css('border-color', 'red');

        msg = msg + " Purchase Rate is Required."
        count++;
    }
    else {
        $('#earning-amount').css('border-color', '');
    }

    if (count > 0) {
        GlobalFunctions.GetMessage(msg, null, 0, 0, null, null);
        return;
    }
    var R = $("#tblEarnings tr:gt(0)").length;
    R = R - 1;
    $("#tblEarnings tbody tr:first").after('<tr id="row' + R + '">' + TblTd(R) + '</tr>');
    fnResetTbltxt();

});


//----For checking Input number int only-----
function isNumeric(evt) {
    var theEvent = evt || window.event;
    var key = theEvent.keyCode || theEvent.which;
    key = String.fromCharCode(key);
    var regex = /[0-9]|\./;
    if (!regex.test(key)) {
        theEvent.returnValue = false;
        if (theEvent.preventDefault) theEvent.preventDefault();
    }
}