const database = require('../utils/database.js');

const UserModel = {
    async CreateUser(userData){
        let query = `INSERT INTO auth_user(email, password) values('${userData.email}', '${userData.password}' )`;
        return await database.promise().query(query);
    },
    async GetUsers(){
        let query = `SELECT * FROM auth_user`;
        return await database.promise().query(query);
    },
    async GetUser(userData){
        let query = `SELECT * FROM auth_user WHERE email = '${userData.email}'`;
        return await database.promise().query(query);
    }
};

module.exports = UserModel;