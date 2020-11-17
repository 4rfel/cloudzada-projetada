module.exports = {
    HOST: "172.31.48.5",
    USER: "tasklist_app",
    PASSWORD: "senha_app",
    DB: "tasklist",
    dialect: "mysql",
    pool: {
        max: 5,
        min: 0,
        acquire: 30000,
        idle: 10000
    }
};