const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
    username:{
        type: String,
    },

    password:{
        type: String,
    },
 
    phonenumber:{
        type: String
    },

});

module.exports = userSchema;
