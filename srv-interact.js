function sendFace() {
    var picture = new Image();
    var canvas = document.getElementById("canvasOutput");

    picture.id = "pic";
    picture.src = canvas.toDataURL();
    
    console.log(picture.src);	
}
