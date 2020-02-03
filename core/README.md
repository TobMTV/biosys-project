# Face recognition docker image

Credits to: [https://github.com/JanLoebel/face_recognition](https://github.com/JanLoebel/face_recognition)

We used a slightly modified version of [@JanLoebel](https://github.com/JanLoebel)'s repository with some edits to make it work on our server.

(To build the image it is suggested to add a swap file on the server as the virtual memory allocated by cmake is not enough for a server with 1GB of RAM)
