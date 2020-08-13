const express = require("express");

const app = express();

app.get("/", async (req, res) => {
  res.json("Hello World!");
});

app.listen(3000, () => {
  console.log("App has started at port 3000");
});
