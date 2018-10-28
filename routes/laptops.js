const express = require('express');
const sql = require('mssql');

const links = require('../constants/links');

const router = express.Router();

const config = require('../config/database');

let user;

router.route('/').get((req, res) => {
  user = res.locals.user;
  new sql.ConnectionPool(config)
    .connect()
    .then(pool => pool.query`EXEC SelectProductList`)
    .then(result => {
      const goods = result.recordset;

      res.render('laptops', { links, goods });
    });
});

router
  .route('/:id')
  .get((req, res) => {
    new sql.ConnectionPool(config)
      .connect()
      .then(
        pool =>
          pool.query`EXEC SelectProduct
     ${req.params.id}`
      )
      .then(result => {
        const good = result.recordset;

        res.render('product', { links, good });
      })
      .catch(err => {
        throw new Error(err);
      });
  })
  .post((req, res) => {
    const { name, id, img } = req.body;
    let arr = [];

    if (!req.cookies[`products${user.id_user}`]) {
      arr.push({ name, id });
    } else {
      arr = [...req.cookies[`products${user.id_user}`], { name, id, img }];
    }
    res.cookie(`products${user.id_user}`, arr);
    res.redirect('/laptops');
  });

module.exports = router;
