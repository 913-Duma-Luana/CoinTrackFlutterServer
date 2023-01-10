const entryServices = require("../services/entries.services");
const upload = require("../middleware/upload");
const req = require("express/lib/request");

exports.create = (req, res, next) => {
    upload(req, res, function (err) {
        if (err) {
            next(err);
        } else {
            const url = req.protocol + "://" + req.get("host");
            const path = req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";
            var model = {
                name: req.body.name,
                year: req.body.year,
                month: req.body.month,
                day: req.body.day,
                time: req.body.time,
                category: req.body.category,
                details: req.body.details,
                value: req.body.value,
            };

            entryServices.createEntry(model, (error, results) => {
                if (error) {
                    return next(error);
                } else {
                    return res.status(200).send({
                        message: "Success",
                        data: results,
                    });
                }
            });
        }
    });
};

exports.findAll = (req, res, next) => {
    var model = {
        name: req.query.name,
    };

    entryServices.getEntries(model, (error, results) => {
        if (error) {
            return next(error);
        } else {
            //console.log(typeof results[0]);
            return res.status(200).send({
                message: "Success",
                data: results.map((result) => result.toObject({ getters: true })),
            });
        }
    });
};

exports.findOne = (req, res, next) => {
    var model = {
        id: req.params.id,
    };

    entryServices.getEntryById(model, (error, results) => {
        if (error) {
            return next(error);
        } else {
            return res.status(200).send({
                message: "Success",
                data: results,
            });
        }
    });
};

exports.update = (req, res, next) => {
    upload(req, res, function (err) {
        if (err) {
            next(err);
        } else {
            const url = req.protocol + "://" + req.get("host");
            const path = req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";
            var model = {
                id: req.params.id,
                name: req.body.name,
                year: req.body.year,
                month: req.body.month,
                day: req.body.day,
                time: req.body.time,
                category: req.body.category,
                details: req.body.details,
                value: req.body.value,
                energy: req.body.energy,
                friends: req.body.friends,
            };

            entryServices.updateEntry(model, (error, results) => {
                if (error) {
                    return next(error);
                } else {
                    return res.status(200).send({
                        message: "Success",
                        data: results,
                    });
                }
            });
        }
    });
};

exports.delete = (req, res, next) => {
    var model = {
        id: req.params.id,
    };

    entryServices.deleteEntry(model, (error, results) => {
        if (error) {
            return next(error);
        } else {
            return res.status(200).send({
                message: "Success",
                data: results,
            });
        }
    });
};
