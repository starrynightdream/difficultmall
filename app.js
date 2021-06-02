const path = require('path');
const fs = require('fs');

const express = require('express');
const session = require('express-session');

const inpolist = [
    require('./router/index'),
    require('./router/order'),
    require('./router/products'),
    require('./router/user'),
];

const app = express();
const port = 3333;

app.use(express.json());
app.use(express.urlencoded({extended:false}));
app.use(session({
    secret: 'and secret in there',
    resave: false,
    saveUninitialized: true,
}));

app.set('views', path.join(__dirname, '/view')); 
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'html');

app.use('/', express.static( path.join( __dirname, "/public/")));

// 跨域请求允许
app.all('*', (req, res, next)=>{
    // 允许的域，*为任意域名
    res.header("Access-Control-Allow-Origin","*");
    // 允许的header类型
    res.header("Access-Control-Allow-Headers","content-type");
    // 允许的请求方式 
    res.header("Access-Control-Allow-Methods","DELETE,PUT,POST,GET,OPTIONS");
    if (req.method.toLowerCase() === 'options')
        res.send(200);  //让options尝试请求快速返回
    else
        next();
});


const appHead= fs.readFileSync( path.join( __dirname, '/view/_head.txt'), 'utf-8');
const appFoot= fs.readFileSync( path.join( __dirname, '/view/_foot.txt'), 'utf-8');


for (let router of inpolist){
    router.inject({appHead, appFoot});
    app.use(`/${router.wantUrl}`, router.router);
}

app.post('/session', (req, res) =>{
    res.json(req.session);
})

app.get('/', (req, res) =>{
    res.redirect('/index/');
    // res.sendFile( path.join(__dirname, "view/index.html")); // 相对路径
});

app.get('*', (req, res)=>{
    res.end('404');
})

app.listen(port, ()=>{
    console.log('now run at port' + port);
});