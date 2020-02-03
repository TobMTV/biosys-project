<?php

	// Extracting just the base64 data from post request
	$image = $_POST["image"];
	$id = $_POST["id"];
	
	echo("Values acquired\n\nIMAGE=" . $image ."\n\nID=" . $id . "\n\n");

	$b64image = explode(',',$image);

	echo("Image exploded (,)\n\n");

	// Saving binary image to temporary file
	$filename="/var/www/html/i/" . substr(md5(rand()), 0, 5) . ".png";
	file_put_contents($filename, base64_decode($b64image[1]));
	
	echo("Converted image is here" . $filename . "\n\n");	

	// Sending image to Docker container

	exec( "curl -X POST -F file=@" . $filename . " http://localhost:8080/faces?id=" . $id);

	echo("request sent");
?>
