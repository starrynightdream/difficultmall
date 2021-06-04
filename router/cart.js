/**
 * 购物车控制
 */
const express = require('express');

const mutil = require('../util');
const po = require('../po');
const server = require('../server');

const wantUrl = 'cart';

const router = express.Router();
let session = undefined;
let HHEAD = '';
let HFOOT = '';

router.post('/updateBuyNum', async (req, res) =>{
    let {cartID, buyNum} = req.body;
    let cart = {...po.Cart};
    cart.cartID = cartID;
    cart.num = buyNum;

    server.Cart.updateCart(cart);
});

router.post('/delCart', async (req, res) =>{
    let {cartID} = req.body;
    server.Cart.delCart(cartID);
});
router.post('/addCart', async (req, res) =>{
    let uid = req.session.uid;
    if (!uid){
        res.redirect('/index/login');
        return;
    }
    let {buyNum, pid} = req.body;
    buyNum = Number.parseInt(buyNum);
    if (!buyNum){
        res.redirect(`/${wantUrl}/showcart`);
        return;
    }
    let cart = {...po.Cart};
    cart.user_id = uid; cart.num = buyNum; cart.pid = pid;

    let _cart = await server.Cart.findCart(cart);

    if (_cart.length == 0){
        await server.Cart.addCart(cart);
    }else{
        cart.cartID = _cart[0].cartID;
        await server.Cart.updateCart(cart);
    }

    res.redirect(`/${wantUrl}/showcart`);
});
router.get('/addCart', async (req, res) =>{
    let uid = req.session.uid;
    if (!uid){
        res.redirect('/index/login');
        return;
    }
    let {buyNum, pid} = req.query;
    buyNum = Number.parseInt(buyNum);
    if (!buyNum){
        res.redirect(`/${wantUrl}/showcart`);
        return;
    }
    let cart = {...po.Cart};
    cart.user_id = uid; cart.num = buyNum; cart.pid = pid;

    let _cart = await server.Cart.findCart(cart);

    if (_cart.length == 0){
        await server.Cart.addCart(cart);
    }else{
        cart.cartID = _cart[0].cartID;
        await server.Cart.updateCart(cart);
    }

    res.redirect(`/${wantUrl}/showcart`);
});
router.get('/showcart', async (req, res) =>{
    let uid = req.session.uid;
    if (!uid){
        res.redirect('/index/login');
        return;
    }
    let carts = await server.Cart.showcart( uid);
    let {HEAD, FOOT} = await mutil.getHeadAndFoot(req.session);

    res.render('cart', {HEAD, FOOT, carts});
});

const inject = ({appHead, appFoot}) =>{
    HHEAD = appHead; HFOOT = appFoot;
}

module.exports = {
    router, wantUrl, inject
}