const express = require("express");
const app = express();
const mongoose = require("mongoose");
const { MONGO_DB_CONFIG } = require("./config/app.config");
const errors = require("./middleware/errors");

// mongoose.Promise = global.Promise;
// mongoose.connect(MONGO_DB_CONFIG.DB, {
//     useNewUrlParser: true,
//     useUnifiedTopology: true
// }).then(
//     () => {
//         console.log("Database connected");
//     }, 
//     (error) => {
//         console.log("Database can't be connected: " + error);
//     }
// );

mongoose
  .connect(
    `mongodb+srv://${process.env.DB_USER}:${process.env.DB_PASSWORD}@cluster1.u3gnnfe.mongodb.net/${process.env.DB_NAME}?retryWrites=true&w=majority`
  ) // mern = db name
  .then(() => {
    app.listen(process.env.PORT || 5000);
  })
  .catch((err) => {
    console.log(err);
});

app.use((req, res, next) => {
    res.setHeader("Access-Control-Allow-Origin", "*"); //cors, allows certain domains to have access
    res.setHeader(
      "Access-Control-Allow-Headers",
      "Origin, X-Requested-With, Content-Type, Accept"
    ); //specify the headers the requests sent by the browser may have
    res.setHeader("Access-Control-Allow-Methods", "GET, POST, PATCH, DELETE, PUT");
    next();
  });

app.use(express.json());
app.use('/uploads', express.static('uploads'));
app.use('/api', require("./routes/app.routes"));
app.use(errors.errorHandler);

// app.listen(process.env.port || 4000, function () {
//     console.log("ready to go");
// });