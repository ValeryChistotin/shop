const express = require('express');
const sql = require('mssql');
const passport = require('passport');
const bcrypt = require('bcryptjs');

const router = express.Router();

const config = require('../config/database');

const userStatusId = 1;

router
  .route('/register')
  .get((req, res) => {
    res.render('register');
  })
  .post((req, res) => {
    const { username, mail, address, password } = req.body;

    req.checkBody('username', 'Username is required').notEmpty();
    req.checkBody('password', 'Password is required').notEmpty();
    req.checkBody('password2', 'Password do not match').equals(password);

    const errors = req.validationErrors();
    if (errors) {
      res.render('register', {
        errors
      });
    } else {
      // const user = {
      //   username,
      //   mail,
      //   address
      // };
      const user = {};
      user.username = username;
      user.mail = mail;
      user.address = address;
      bcrypt.genSalt(10, (err, salt) => {
        bcrypt.hash(password, salt, (err, hash) => {
          if (err) throw err;
          user.password = hash;
          new sql.ConnectionPool(config)
            .connect()
            .then(
              pool =>
                pool.query`EXEC AddNewUser ${userStatusId}, ${user.username}, ${
                  user.mail
                }, 123, ${user.address}, ${user.password}`
            )
            .then(res.redirect('/users/login'))
            .catch(err => {
              throw err;
            });
        });
      });
    }
  });

router
  .route('/login')
  .get((req, res) => {
    res.render('login');
  })
  .post((req, res, next) => {
    passport.authenticate('local', {
      successRedirect: '/home',
      failureRedirect: '/users/login',
      failureFlash: true
    })(req, res, next);
  });

router.get('/logout', (req, res) => {
  req.logout();
  req.flash('success', 'You have logged out');
  res.redirect('/users/login');
});

module.exports = router;
