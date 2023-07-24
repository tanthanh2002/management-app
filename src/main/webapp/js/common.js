function setCookie(cname, cvalue, exdays) {
    const d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    let expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
    let name = cname + "=";
    let decodedCookie = decodeURIComponent(document.cookie);
    let ca = decodedCookie.split(';');
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function isLogin() {
    const curUser = getCookie("curUser");

    if (curUser) {
        return;
    } else {
        window.location.href = "/login";
    }
};

function logOut(){
    setCookie("curUser","",0);
    window.location.href = "/login";
}

function pagination(page) {
    var currentPath = window.location.href;
    var newPath = "";
    if (currentPath.includes("page=")) {
        currentPath = currentPath.substring(0, currentPath.indexOf("page=") - 1);
    }
    newPath = currentPath;
    if(newPath.includes('?')){
        newPath = newPath + ("&page=" + page);
    }else {
        newPath = newPath + ("?page=" + page);
    }

    window.location.href = newPath;
    console.log(newPath);
}