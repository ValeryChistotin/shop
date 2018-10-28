const LocalStrategy = require('passport-local').Strategy;
const sql = require('mssql');
const config = require('./database');
const bcrypt = require('bcryptjs');

module.exports = passport => {
  passport.use(
    new LocalStrategy((username, password, done) => {
      new sql.ConnectionPool(config)
        .connect()
        .then(
          pool => pool.query`SELECT * FROM users WHERE fullname = ${username} `
        )
        .then(result => {
          const users = result.recordset;
          if (!users.length) {
            return done(null, false, { message: 'No user found.' });
          }

          bcrypt.compare(password, users[0].password, (err, isMatch) => {
            if (err) throw err;
            if (isMatch) {
              return done(null, users[0]);
            }

            return done(null, false, { message: 'Wrong password.' });
          });
        })
        .catch(err => {
          throw err;
        });
    })
  );

  passport.serializeUser((user, done) => done(null, user.id_user));

  passport.deserializeUser((id, done) => {
    new sql.ConnectionPool(config)
      .connect()
      .then(pool => pool.query`SELECT * FROM users WHERE id_user = ${id}`)
      .then(result => {
        const user = result.recordset[0];

        done(null, user);
      })
      .catch(err => {
        throw err;
      });
  });
};
