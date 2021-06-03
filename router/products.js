/**
 * 产品控制
 */
const fs = require('fs');
const path = require('path');

const express = require('express');
const server = require('../server');
const mutil = require('../util');

const wantUrl = 'productsController';

const router = express.Router();
let session = undefined;

let HHEAD = '';
let HFOOT= '';

router.post('/productsclass', async (req, res) =>{
    let data = await server.Products.allcategorys();
    res.json(data.join(','));
});

router.use('/prodlist', async (req, res) =>{

    let name = req.body.name || '';
    let category = req.body.category || '';
    let minPrice = Number.parseFloat(req.body.minprice) || 0;
    let maxPrice = Number.parseFloat(req.body.maxprice) || 100000;

    if (maxPrice < minPrice){
        maxPrice = minPrice;
    }

    let searchObj = {
        name, category, minPrice, maxPrice
    } 

    let categorys = await server.Products.allcategorys();
    let products = await server.Products.prodlist(searchObj);

    req.session.data = {
        name, minPrice, maxPrice, categorys, products 
    };
    
    let {HEAD, FOOT} = await mutil.getHeadAndFoot(req.session);
    res.render('prod_list', {HEAD, FOOT, 'data': req.session.data});

    // fs.readFile( path.join( __dirname, '../view/prod_list.html'), 'utf-8', (err, data) =>{

    //     if (err){
    //         next();
    //         return;
    //     }
    //     data = data.replace('{{head}}', HEAD).replace('{{foot}}', FOOT);
    //     res.send(data);
    // });
});
router.get('/prodInfo', async (req, res) =>{
    let product = await server.Products.oneProduct(req.query.pid);
    product = product[0];
    req.session.product = product;

    let {HEAD, FOOT} = await mutil.getHeadAndFoot(req.session);
    res.render('prod_info', {HEAD, FOOT, 'data': req.session.data});

    // fs.readFile( path.join( __dirname, '../view/prod_info.html'), 'utf-8', (err, data) =>{

    //     if (err){
    //         next();
    //         return;
    //     }
    //     data = data.replace('{{head}}', HEAD).replace('{{foot}}', FOOT);
    //     res.send(data);
    // });
});
router.get('/prodclass/:proclass', async (req, res) =>{
    let proclass = req.params.proclass;
    let products = await server.Products.proclass(decodeURI(proclass));
    if (req.session.data){
        req.session.data.products = products;
    } else{
        req.session.data = {products};
    }

    // res.render('prod_list', {head: HEAD, foot: FOOT});

    let {HEAD, FOOT} = await mutil.getHeadAndFoot(req.session);
    res.render('prod_list', {HEAD, FOOT, 'data': req.session.data});

    // fs.readFile( path.join( __dirname, '../view/prod_list.html'), 'utf-8', (err, data) =>{

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