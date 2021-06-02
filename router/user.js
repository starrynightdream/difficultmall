/**
 * 用户功能控制
 */
const crypto = require('crypto');
const express = require('express');

const server = require('../server');
const po = require('../po');

const wantUrl = 'user';

const router = express.Router();
let session = undefined;
let HEAD = '';
let FOOT = '';

router.post('/checkUser',async (req, res) =>{
    let un = req.body.username;
    let ans = await server.User.checkUsername(un);
    if (!ans){
        res.json(`it can use ${un}`);
    } else{
        res.json(`it can't use ${un}`);
    }
});
router.post('/regist', async (req, res) =>{
    let {username, password, password2, nickname} = req.body;

    if (!username || !password || !password2 || !nickname){
        req.session.msg = 'complace please';
        res.redirect('/index/regist');
        return ;
    }

    if (password != password2){
        req.session.msg = 'reinput password err';
        res.redirect('/index/regist');
        return ;
    }

    let alreadyUser = await server.User.checkUsername(username);
    if (alreadyUser){
        req.session.msg = 'already exit';
    }

    let user = {...po.User};
    user.username = username;
    user.nickname = nickname;
    user.password = encode(password);
    let ru = await server.User.regist(user)

    if (ru){
        req.session.msg = 'success success';
        res.redirect('/index/login');
        return ;
    } else{
        req.session.msg = 'regist fail';
        res.redirect('/index/regist');
        return ;
    }
});
router.post('/login', async (req, res) =>{

    if (!req.body.username){
        req.session.msg = 'name loss';
        res.redirect('/index/login');
        return ;
    }
    if (!req.body.password){
        req.session.msg = 'password loss';
        res.redirect('/index/login');
        return ;
    }

    user = {...po.User};
    user.username = req.body.username;
    user.password = encode(req.body.password);

    let u = await server.User.login(user);
    u = u[0];
    if (u){
        req.session.isLogin = true;
        req.session.uname = u.username;
        req.session.uid = u.id;

        res.redirect('/');
        return ;
    } else{
        req.session.msg = 'fail';
        res.redirect('/index/login');
        return ;
    }

});

const encode = (text) =>{
    return crypto.createHash('sha512').update(text).digest('hex');
}

const inject = ({appHead, appFoot}) =>{
    HEAD = appHead; FOOT = appFoot;
}

module.exports = {
    router, wantUrl, inject
}