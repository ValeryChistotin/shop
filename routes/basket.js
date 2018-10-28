const express = require('express');
const sql = require('mssql');

const links = require('../constants/links');

const router = express.Router();

const config = require('../config/database');

let user;

router
  .route('/')
  .get((req, res) => {
    let products;

    user = res.locals.user;

    if (user) {
      products = req.cookies[`products${user.id_user}`];
    }

    res.render('basket', { links, products });
  })
  .post((req, res) => {
    const orderStatus = 0;
    const { id, quantity } = req.body;

    new sql.ConnectionPool(config)
      .connect()
      .then(
        pool =>
          pool.query`EXEC AddNewOrder ${orderStatus}, ${
            user.id_user
          }, ${id}, ${quantity || 1}`
      )
      .then(() => {
        res.redirect('/home');
      })
      .catch(err => console.log(err));
  });

module.exports = router;
