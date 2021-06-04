
const fs = require('fs');
const path = require('path');
const ejs = require('ejs');
const server = require('./server');


let headTemplate = '';
let footTemplate = '';

const getHeadAndFoot = async (session) =>{
    let allClass = await server.Products.allcategorys();

    let HEAD = ejs.render(headTemplate, {session, allClass});
    let FOOT = ejs.render(footTemplate, {});

    return {HEAD, FOOT};
}

const injuct = (head, foot) =>{
    headTemplate = head;
    footTemplate = foot;
}

const format = function (date, pattern) {
    if (!date) {
        date = new Date;
    } else {
        if (!isDate(date)) {
            date = new Date(date);
        }
    }
    pattern = pattern || 'yyyy-MM-dd';
    var y = date.getFullYear().toString();
    var o = {
        M: date.getMonth() + 1, //month
        d: date.getDate(), //day
        h: date.getHours(), //hour
        m: date.getMinutes(), //minute
        s: date.getSeconds() //second
    };
    pattern = pattern.replace(/(y+)/ig, function (a, b) {
        return y.substr(4 - Math.min(4, b.length));
    });
    for (var i in o) {
        pattern = pattern.replace(new RegExp('(' + i + '+)', 'g'), function (a, b) {
            return (o[i] < 10 && b.length > 1) ? '0' + o[i] : o[i];
        });
    }
    return pattern;
}

const fixNoThing = async (session) =>{
    let uid = session.uid;
    let carts = [];
    let cartIds = '';

    if (!uid){
        return {carts, cartIds};
    }

    carts = await server.Cart.showcart( uid);
    cartIds = []
    for (let c of carts){
        cartIds.push(c.cartID);
    }
    cartIds =  cartIds.join(',');

    return {_carts: carts, _cartIds: cartIds};
}

module.exports = {
    getHeadAndFoot, format ,injuct, fixNoThing
}