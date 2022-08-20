const FCM = require('fcm-node');

//var serverKey = require('./server_key.json');

var fcm = new FCM('AAAAKptjfW8:APA91bFdksLlT-bddkp1hmAy4ZORnO9W8ZP6kJK9mbshqGS3yHbXY3hvQmihDQW_HoHqoaKEjTEQkDkbBc1a_A-0WJ3LkExJJrB_SGwM3Xe3EcFO8zYAfE-HMayMFp2bqPXmRjg_7SZi');

const fcmController = {
    async token_post(req, res) { 
        try{
            let{ token } = req.body;
            console.log("token generated ----->", token);
            res.send({
                status: true,
                message: `token sent successfully ${token}`,
                });
            
            var tokencreated = fcmController.token_post;
            console.log("created token ", tokencreated);
            var message = {
    
            "to": 
                token
    ,
    
    "notification" : {
        title: 'Testing notification',
        body: 'This is to notify that the test is success'
    },
}

fcm.send(message, function(err, response) { 
    if(err){
        console.log('Something is wrong ', err);
    }
    else{
        console.log("Success ", response);
    }
});
        }
        catch(err){
            console.log("Some ", err);
            res.send({
                status: false,
                message: `err ${err}`,
                });
        }
    }
}


module.exports = fcmController;