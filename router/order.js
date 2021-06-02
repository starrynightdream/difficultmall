/**
 * 订单控制
 */
const express = require('express');
const uuid = require('uuid');

const server = require('../server');
const po = require('../po');

const wantUrl = 'order';

const router = express.Router();
let session = undefined;
let HEAD = '';
let FOOT = '';

router.get('/order_add', async (req, res) =>{
    let arrCartIds =  req.body.cartIds.split(',');

    let carts = [];
    for (let cid of arrCartIds){
        cid = Number.parseInt(cid);
        let cart = await server.Cart.findByCartID(cid);
        carts.push(cart);
    }

    res.render('order_add',{HEAD, FOOT, carts, cartIds});
});
router.get('/addOrder', async (req, res) =>{
    let {receiverinfo, cartIds} = req.query;
    let timestamp = new Date();
    let uid = req.session.uid;
    if (!uid){
        res.redirect('/');
    }

    let order = {...po.Order};
    order.receiverinfo = receiverinfo;
    order.id = uuid.v4();
    order.ordertime = timestamp;
    order.user_id = uid;

    await server.Order.addOrder(cartIds, order);

    res.redirect('/order/showorder');
});
router.get('/showorder', async (req, res) =>{
    let uid = req.session.uid;
    if (!uid){
        res.redirect('/');
    }
    let orderInfos = await joinMap(uid);

    res.render('order_list', {HEAD, FOOT, orderInfos, 'username': req.session.uname});
});
router.get('/delorder', async (req, res) =>{
    let id = req.body.id;
    await server.Order.delorder(id);
    res.redirect('/order/showorder');
});
router.get('/payorder', async (req, res) =>{
    let id = req.body.id;
    await server.Order.payorder(id);

    let orderitems = await server.Order.orderitem(id);

    for (let orderitem of orderitems){
        let product = await server.Products.oneProduct(orderitem.product_id);

        let map ={};
        map.id = product.id;
        map.pnum = orderitem.buynum;
        await server.Products.updatepnum(map);
    }

    res.redirect('/order/showorder');
});
router.get('/confirmorder', async (req, res) =>{
    let id = req.body.id;
    await server.Order.confirmorder(id);
    res.redirect('/order/showorder');
});

const joinMap = async (uid) =>{
    let orderInfos = [];
    let orders = await server.Order.findOrderByUserId(uid);

    for (let order of orders){
        let orderItems = await server.Order.orderitem(order.id);
        let map = new Map();

        for (let orderItem of orderItems){
            let product = await server.Products.oneProduct(orderItem.product_id);
            map.set(product, orderItem.buynum);
        }
        let orderInfo = {...po.OrderInfo};
        orderInfo.map = map;
        orderInfo.order = order;
        
        orderInfos.push(orderInfo);
    }

    return orderInfos;
}

const inject = ({appHead, appFoot}) =>{
    HEAD = appHead; FOOT = appFoot;
}

module.exports = {
    router, wantUrl, inject
}