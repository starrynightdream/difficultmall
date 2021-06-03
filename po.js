const User = {
    id : undefined, username : undefined, password : undefined, 
    nickname : undefined, email : undefined,
};

const MyCart = {
    cartID : undefined, pid : undefined, name : undefined,
    imgurl : undefined, price : undefined, num : undefined
};

const Cart = {
    cartID : undefined, user_id : undefined, pid : undefined, num : undefined
}

const Order = {
    id : undefined, money : undefined, receiverinfo : undefined,
    paystate : 0, ordertime : undefined, user_id: undefined
}

const OrderItem = {
    order_id : undefined, product_id : undefined, buynum : undefined,
}

const OrderInfo = {
    order: undefined, map: new Map(),
}

module.exports = {
    User, MyCart, Cart, Order, OrderItem, OrderInfo
}