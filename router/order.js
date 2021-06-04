/**
 * 订单控制
 */
const express = require('express');
const ejs = require('ejs');
const uuid = require('uuid');

const server = require('../server');
const po = require('../po');
const mutil = require('../util');

const wantUrl = 'order';

const router = express.Router();
let session = undefined;
let HHEAD = '';
let HFOOT = '';

router.post('/order_add', async (req, res) =>{
    let arrCartIds = (req.body.cartIds && req.body.cartIds.split(',')) || [];
    let cartIds = req.body.cartIds;

    let carts = [];
    for (let cid of arrCartIds){
        cid = Number.parseInt(cid);
        let cart = await server.Cart.findByCartID(cid);
        if (cart[0])
            carts.push(cart[0]);
    }
    // 为场景做特指适应
    if (carts.length === 0){
        // 如果出现请求的数据为空或者全错的情况，则对所有商品下单
        
        let uid = req.session.uid;
        if (!uid){
            res.redirect('/index/login');
            return;
        }
        carts = await server.Cart.showcart( uid);
        cartIds = []
        for (let c of carts){
            cartIds.push(c.cartID);
        }
        cartIds.join(',');
    }
    req.session.orderAdd =  {carts, cartIds};
    // let nHead = ejs.render(HEAD, {'session': req.session});
    // let nFoot = ejs.render(FOOT, {});
    
    // let {HEAD, FOOT} = await mutil.getHeadAndFoot(req.session);

    res.end('ok');
    // res.render('order_add',{HEAD, FOOT, carts, 'cartIds': req.body.cartIds});
});

router.get('/order_add', async (req, res) =>{
    // let arrCartIds = (req.body.cartIds && req.body.cartIds.split(',')) || [];

    // let carts = [];
    // for (let cid of arrCartIds){
    //     cid = Number.parseInt(cid);
    //     let cart = await server.Cart.findByCartID(cid);
    //     carts.push(cart[0]);
    // }
    // let nHead = ejs.render(HEAD, {'session': req.session});
    // let nFoot = ejs.render(FOOT, {});
    if (!req.session.orderAdd){
        let carts = [];
        let cartIds = '';
        req.session.orderAdd = {
            carts, cartIds
        }
    }

    console.log(req.session.orderAdd);
    
    let {HEAD, FOOT} = await mutil.getHeadAndFoot(req.session);

    res.render('order_add',{
        HEAD, FOOT, 'carts': req.session.orderAdd.carts, 
        'cartIds': req.session.orderAdd.cartIds
    });
});

router.use('/addOrder', async (req, res) =>{
    console.log(req.body);
    let {receiverinfo, cartIds} = req.body;
    let timestamp = mutil.format();
    let uid = req.session.uid;
    if (!uid){
        res.redirect('/');
        return;
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
        return;
    }
    let orderInfos = await joinMap(uid);

    // let nHead = ejs.render(HEAD, {'session': req.session});
    // let nFoot = ejs.render(FOOT, {});

    // res.render('order_list', {'HEAD': nHead, 'FOOT': nFoot, orderInfos, 'username': req.session.uname});

    let {HEAD, FOOT} = await mutil.getHeadAndFoot(req.session);

    res.render('order_list',{HEAD, FOOT, orderInfos, 'username': req.session.uname});
});
router.get('/delorder', async (req, res) =>{
    let id = req.query.id;
    await server.Order.delorder(id);
    res.redirect('/order/showorder');
});
router.get('/payorder', async (req, res) =>{
    let id = req.query.id;
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
    let id = req.query.id;
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
    HHEAD = appHead; HFOOT = appFoot;
}

module.exports = {
    router, wantUrl, inject
}