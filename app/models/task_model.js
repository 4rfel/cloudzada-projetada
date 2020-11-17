module.exports = (sequelize, Sequelize) => {

    const Task = sequelize.define("task", {
        uuid: {
            type: Sequelize.UUID,
            defaultValue: Sequelize.UUIDV4,
            allowNull: false,
            primaryKey: true
        },
        description: {
            type: Sequelize.STRING
        }
    });
    return Task;    
};