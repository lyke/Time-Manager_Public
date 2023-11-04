export function disableUpdateUserInputs() {
    document.getElementsByName("email")[0].disabled = true;
    document.getElementsByName("firstname")[0].disabled = true;
    document.getElementsByName("lastname")[0].disabled = true;
    document.getElementsByName("password")[0].disabled = true;
    document.getElementById("update-user-button").style.display = "none";
}

export function enableUpdateUserInputs() {
    var updateUserButton = document.getElementById("update-user-button").style.display;
    if (updateUserButton == "initial") {
        hide();
    } else {
        document.getElementsByName("email")[0].disabled = false;
        document.getElementsByName("firstname")[0].disabled = false;
        document.getElementsByName("lastname")[0].disabled = false;
        document.getElementsByName("password")[0].disabled = false;
        document.getElementById("update-user-button").style.display = "initial";
    }
}

function hide() {
    document.getElementsByName("email")[0].disabled = true;
    document.getElementsByName("firstname")[0].disabled = true;
    document.getElementsByName("lastname")[0].disabled = true;
    document.getElementsByName("password")[0].disabled = true;
    document.getElementById("update-user-button").style.display = "none";
}