/**
 * 页面跳转的控制
 */
const path = require('path');
const fs = require('fs')
const express = require('express');
const ejs = require('ejs');

const mutil = require('../util');

const wantUrl = 'index';

const router = express.Router();
let session = undefined;
let HHEAD = '';
let HFOOT= '';

router.get('/login', (req, res) =>{
    // 登录页
    res.sendFile( path.join( __dirname, '../view/login.html'));
});
router.get('/logout', (req, res) =>{
    req.session.isLogin = false;
    res.redirect(`/${wantUrl}/`);
});
router.get('/regist', (req, res) =>{
    // 注册页
    res.sendFile( path.join( __dirname, '../view/regist.html'));
});
router.get('/', async (req, res, next) =>{
    // 主页
    // let nHead = ejs.render(HEAD, {'session': req.session});
    // let nFoot = ejs.render(FOOT, {});
    let {HEAD, FOOT} = await mutil.getHeadAndFoot(req.session);
    res.render('index', {HEAD, FOOT});
    // fs.readFile( path.join( __dirname, '../view/index.html'), 'utf-8', (err, data) =>{

    //     if (err){
    //         next();
    //         return;
    //     }
    //     data = data.replace('{{head}}', HEAD).replace('{{foot}}', FOOT);
    //     res.send(data);
    // });
});

const inject = ({appHead, appFoot}) =>{
    HHEAD = appHead; HFOOT = appFoot;
}

module.exports = {
    router, wantUrl, inject
}