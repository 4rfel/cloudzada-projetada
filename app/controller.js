const db = require("./models/index"); // models path depend on your structure
const Task = db.taks;

exports.create = (req, res) => {
  if (!req.body.description) {
    res.status(400).send({
      message: "Content can not be empty!"
    });
    return;
  }

  const task = {
    description: req.body.description
  };

  Task.create(task)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while creating the Task."
      });
    });
};

exports.findAll = (req, res) => {
    const uuid = req.query.uuid;
    var condition = uuid ? { uuid: { [Op.like]: `%${uuid}%` } } : null;
  
    Task.findAll({ where: condition })
        .then(data => {
        res.send(data);
        })
        .catch(err => {
        res.status(500).send({
            message:
                err.message || "Some error occurred while retrieving tutorials."
        });
    });
};

  exports.delete = (req, res) => {
    const uuid = req.params.uuid;
  
    Tutorial.destroy({
         where: { uuid: uuid }
    })
    .then(num => {
        if (num == 1) {
            res.send({
                message: "Task was deleted successfully!"
            });
        } else {
            res.send({
                message: `Cannot delete Task with uuid=${uuid}. Maybe Task was not found!`
            });
        }
    })
    .catch(err => {
        res.status(500).send({
            message: "Could not delete Task with uuid=" + uuid
        });
    });
};