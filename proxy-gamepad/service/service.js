const express = require('express');
const cors = require('cors');
const app = express();
const PORT = 8001;
let global_connection = null;

var WebSocketClient = require('websocket').client;
var client = new WebSocketClient();

app.use(cors());
app.options('*', cors());

app.get('/', (req, res) => {    
    console.log("init")
    res.send()
});

app.get('/:command/:id', (req, res) => {    
    let command = req.params.command
    let id = req.params.id
    let json = `${id}:${command}`

    global_connection.sendUTF(json);
    res.send()
});

app.use(function (req, res) {
    res.status(404).send();
});

app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}...`);
});

client.on('connect', function(connection) {
    global_connection = connection;

    connection.on('error', function(error) {
        console.log("Connection Error: " + error.toString());
    });
    connection.on('close', function() {
        console.log('Connection Closed');
    });
    connection.on('message', function(message) {
        if (message.type === 'utf8') {
            console.log("Received: '" + message.utf8Data + "'");
        }
    });
});

client.connect('ws://localhost:8000/', '');