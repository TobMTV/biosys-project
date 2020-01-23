function sendFace() {
    // Getting image from canvas to base64
    var picture = new Image();
    var canvas = document.getElementById("canvasOutput");
    picture.id = "pic";
    picture.src = canvas.toDataURL();

    // Placeholder
    var login = document.getElementById("login");
    var id = login.value;

    // Actual request
    xhr = new XMLHttpRequest();
    xhr.open('POST', 'https://biosys.casalinovalerio.com/send-faces.php', true);
    xhr.send("image=" + picture.src + "&id=" + id );

    alert(xhr.response);
}

function recoFace() {
    // Getting image from canvas to base64
    var picture = new Image();
    var canvas = document.getElementById("canvasOutput");
    picture.id = "pic";
    picture.src = canvas.toDataURL();

    // Placeholder
    var login = document.getElementById("login");
    var id = login.value;

    // Actual request
    xhr = new XMLHttpRequest();
    xhr.open('POST', 'https://biosys.casalinovalerio.com/reco-faces.php', true);
    xhr.send("image=" + picture.src + "&id=" + id );

    alert(xhr.response);
}