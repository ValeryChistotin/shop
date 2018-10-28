const express = require('express');
const sql = require('mssql');
const path = require('path');

const links = require('./constants/links');

const bodyParser = require('body-parser');
const flash = require('connect-flash');
const passport = require('passport');
const expressMessages = require('express-messages');

const cookieParser = require('cookie-parser');

const session = require('./middleware/session');
const expressValidator = require('./middleware/expressValidator');

const laptops = require('./routes/laptops');
const users = require('./routes/users');
const basket = require('./routes/basket');

const app = express();
const port = 3030;

const config = require('./config/database');

app.set('view engine', 'pug');

app.use(express.static(path.join('public')));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use(cookieParser());

app.use(session);

app.use(flash());
app.use((req, res, next) => {
  res.locals.messages = expressMessages(req, res);
  next();
});

app.use(expressValidator);

require('./config/passport')(passport);

app.use(passport.initialize());
app.use(passport.session());

app.get('*', (req, res, next) => {
  res.locals.user = req.user || null;
  next();
});

app.get('/home', (req, res) => {
  res.render('home', { links });
});

app.use('/laptops', laptops);

app.get('/computers', (req, res) => {
  new sql.ConnectionPool(config)
    .connect()
    .then(pool => pool.query`SELECT * FROM productCatalog`)
    .then(result => {
      const goods = result.recordset;

      res.render('computers', { links, goods });
    });
});

app.use('/basket', basket);

app.use('/users', users);

app.get('/admin', (req, res) => {
  new sql.ConnectionPool(config)
    .connect()
    .then(pool => pool.query`EXEC SelectOrdersForAdmin`)
    .then(result => {
      const orders = result.recordset;

      res.render('admin', { links, orders });
    });
});

app.get('/orders', (req, res) => {
  new sql.ConnectionPool(config)
    .connect()
    .then(
      pool => pool.query`EXEC SelectOrdersForUser ${res.locals.user.id_user}`
    )
    .then(result => {
      const orders = result.recordset;

      res.render('orders', { links, orders });
    })
    .catch(() => res.render('orders', { links }));
});

app.get('/about', (req, res) => {
  res.render('about', { links });
});

app.listen(port, () => console.log(`Listening on port ${port}...`));
