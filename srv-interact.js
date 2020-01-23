function sendFace() {
    var picture = new Image();
    var canvas = document.getElementById("canvasOutput");

    picture.id = "pic";
    picture.src = canvas.toDataURL();

    // Placeholder
    var login = document.getElementById("login");
    var id = login.value;

    xhr = new XMLHttpRequest();
    xhr.open('POST', 'https://biosys.casalinovalerio.com/send-faces.php', true);
    xhr.send("image=" + picture.src + "&id=" + id );

    alert(xhr.response);
}
