const entriesController = require("../controllers/entries.controller")
const express = require("express");
const router = express.Router();

router.post("/entries", entriesController.create);
router.get("/entries", entriesController.findAll);
router.get("/entries/:id", entriesController.findOne);
router.put("/entries/:id", entriesController.update);
router.delete("/entries/:id", entriesController.delete);

module.exports = router;