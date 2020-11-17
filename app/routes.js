module.exports = app => {
    const task = require("./controller.js");
  
    var router = require("express").Router();
  
    router.post("/", task.create);
  
    router.get("/", task.findAll);
  
    router.delete("/:uuid", task.delete);
  
    app.use('/task', router);
  };