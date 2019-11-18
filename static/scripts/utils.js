function checkMobile(str) {
    var re = /^1\d{10}$/;
    return re.test(str);
}