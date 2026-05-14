import express from 'express';
import router from './routes/index.js';
import cookieParser from 'cookie-parser'
import session from 'express-session';
import bodyParser from 'body-parser'
import path from 'path';
import config from './config'

const app = express();

app.use(express.static(path.join(__dirname, 'public')));



app.all('*', (req, res, next) => {
  res.header("Access-Control-Allow-Origin", req.headers.origin || '*');
  res.header("Access-Control-Allow-Headers", "Content-Type, Authorization, X-Requested-With");
  res.header("Access-Control-Allow-Methods", "PUT,POST,GET,DELETE,OPTIONS");
  res.header("Access-Control-Allow-Credentials", true); //可以带cookies
  res.header("X-Powered-By", '3.2.1');
  res.header("Cache-Control", "public,max-age=60000");
  if (req.method === 'OPTIONS') {
    res.send(200);
  } else {
    next();
  }
});

app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json({}));
app.use(cookieParser());
app.use(session({
  name: 'ele-session',
  secret: 'eleme',
  resave: true,
  saveUninitialized: false,
  cookie: {
    httpOnly: true,
    secure: false,
    maxAge: 365 * 24 * 60 * 60 * 1000,
  }
}));
router(app);
// app.use(history());
console.log('*********************************')
console.log(`service start on ${config.port}`)
console.log('*********************************')
app.listen(config.port);

module.exports = app;
