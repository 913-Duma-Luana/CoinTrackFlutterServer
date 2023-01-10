const mongoose = require("mongoose");
const { stringify } = require("nodemon/lib/utils");

const entry = mongoose.model(
    "entries",
    mongoose.Schema({
        name: String,
        year: Number,
        month: Number,
        day: Number,
        time: Number,
        category: String,
        details: String,
        value: Number,
    },
    {
        timestamps: true,
    })
);
module.exports = {
    entry
}