const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

var app = express();

var corsOptions = {
	origin: "http://172.31.48.5:8080"
};

app.use(cors(corsOptions));

app.use(bodyParser.json());

app.use(bodyParser.urlencoded({ extended: true }));

const db = require("./app/models");
db.sequelize.sync();

app.get("/", (req, res) => {
  res.json({ message: "aaaaaaaaaa." });
});	

require("./routes")(app);

var server = app.listen(8000, function () {
})
