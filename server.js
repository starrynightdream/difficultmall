const dao = require('./dao.js');
const po = require('./po');

const User = {};
const Products = {};
const Order = {};
const Cart = {};

User.login = async (user) =>{
    return await dao.login(user);
}

User.checkUsername = async (username) =>{
    let has = await dao.checkUserName({username});
    if (has){
        return true;
    } else {
        return false;
    }
}

User.regist = async (user) =>{
    return await dao.register(user);
}

Products.allcategorys = async () =>{
    let ans = await dao.allcategorys();
    for (let i in ans){
        ans[i] = ans[i].category;
    }
    return ans;
}

Products.prodlist = async (para) =>{
    return await dao.prodlist(para)
}

Products.oneProduct = async (pid) =>{
    return await dao.oneProduct({pid});
}

Products.proclass = async (category) =>{
    return await dao.proclass({category});
}

Products.updatepnum = async (para) =>{
    return await dao.updatepnum(para);
}

Order.addOrder = async (cartIDs, orders) =>{
    cartIDs = cartIDs.split(',');
    let sum = 0;
    for (let carID of cartIDs){
        cid = Number.parseInt(carID);
        mycart = await dao.findByCartID(cid);

        sum += mycart.price * mycart.num;

        orderItem = {...po.OrderItem};
        orderItem.order_id = orders.id;
        orderItem.product_id = mycart.pid;
        orderItem.buynum = buynum;

        await dao.addOrderItem(orderItem);
        await dao.delCart(cid);
    }
    orders.money = sum;
    await dao.addOrder(orders);
}

Order.findOrderByUserId = async (user_id) =>{
    return await dao.findOrderByUserId({user_id});
}

Order.orderitem = async (order_id) =>{
    return await dao.orderitem({order_id});
}

Order.delorder = async (id) =>{
    await dao.delorderitem({id});
    await dao.delorder({id});
}

Order.payorder = async (id) =>{
    await dao.payorder({id});
}

Order.confirmorder = async (id) =>{
    await dao.confirmorder({id});
}

Cart.addCart = async (cart) =>{
    return await dao.addCart(cart);
}

Cart.findCart = async (cart) =>{
    return await dao.findCart(cart);
}

Cart.updateCart = async (cart) =>{
    return await dao.updateCart(cart);
}

Cart.updateBuyNum = async (cart) =>{
    await dao.updateBuyNum(cart);
}

Cart.showcart  = async (user_id) =>{
    return await dao.showCart({user_id});
}

Cart.delCart = async (cartID) =>{
    return await dao.delCart({cartID});
}

Cart.findByCartID = async (cartID) =>{
    return await dao.findByCartID({cartID});
}

module.exports = {
    User, Products, Order, Cart
};