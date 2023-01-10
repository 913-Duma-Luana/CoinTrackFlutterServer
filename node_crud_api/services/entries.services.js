const {entry} = require("../models/entries.model");

async function createEntry(params, callback) {
    if(!params.name) {
        return callback(
            {
                message: "Entry name required",
            },
        );
    }
    const entryModel = entry(params);
    entryModel.save().then((response) => {
        return callback(null, response);
    }).catch((error) => {
        return callback(error);
    });
}

async function getEntries(params, callback) {
    const name = params.name;
    var condition = name ? {
        name: { $regex: new RegExp(name), $option: "i"},
    } : {};
    entry.find(condition).then((response) => {
        return callback(null, response);
    }).catch((error) => {
        return callback(error);
    });
}

async function getEntryById(params, callback) {
    const id = params.id;
    entry.findById(id).then((response) => {
        if(!response) callback("Entry id invalid")
        else return callback(null, response);
    }).catch((error) => {
        return callback(error);
    });
}

async function updateEntry(params, callback) {
    const id = params.id;
    entry.findByIdAndUpdate(id, params, {useFindAndModify: false}).then((response) => {
        if(!response) callback("Entry id invalid")
        else return callback(null, response);
    }).catch((error) => {
        return callback(error);
    });
}

async function deleteEntry(params, callback) {
    const id = params.id;
    entry.findByIdAndRemove(id).then((response) => {
        if(!response) callback("Entry id invalid")
        else return callback(null, response);
    }).catch((error) => {
        return callback(error);
    });
}

module.exports = {
    createEntry,
    getEntries,
    getEntryById,
    updateEntry,
    deleteEntry
}