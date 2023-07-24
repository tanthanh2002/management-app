function isLogin() {
    const curUser = getCookie("curUser");

    if (curUser) {
        return;
    } else {
        window.location.href = "/login";
    }
};

function customAlert(message, type) {
    let typeAlert = ['alert-success', 'alert-danger', 'alert-info'];
    let toast = document.getElementById('customAlert');
    toast.textContent = message;
    toast.classList.add(type);
    var opacity = 0;
    var timer = setInterval(function () {
        if (opacity >= 1) {
            clearInterval(timer);
        }
        toast.style.opacity = opacity;
        opacity += 0.1;
    }, 100);
    setTimeout(function () {
        toast.style.opacity = 0;
        toast.classList.remove(type);
    }, 4000)
}


(function () {
    'use strict'

    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    var forms = document.querySelectorAll('.needs-validation')

    // Loop over them and prevent submission
    Array.prototype.slice.call(forms)
        .forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }

                form.classList.add('was-validated')
            }, false)
        })
})()


$(function () {
    // Tạo đoạn mã HTML của navbar
    var navbarHTML = `
    `;

    // Chèn đoạn mã navbar vào phần đầu của tất cả các tệp HTML
    $('body').prepend(navbarHTML);
});

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

