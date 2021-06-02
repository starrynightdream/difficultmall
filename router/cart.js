/**
 * 购物车控制
 */
const express = require('express');

const serve = require('../server');

const wantUrl = 'order';

const router = express.Router();
let session = undefined;
let HEAD = '';
let FOOT = '';

router.get('/order_add', (req, res) =>{
});
router.get('/addOrder', (req, res) =>{
});
router.get('/showorder', (req, res) =>{
});
router.get('/delorder', (req, res) =>{
});
router.get('/payorder', (req, res) =>{
});
router.get('/confirmorder', (req, res) =>{
});

const inject = ({appHead, appFoot}) =>{
    HEAD = appHead; FOOT = appFoot;
}

module.exports = {
    router, wantUrl, inject
}