const mysql = require('mysql');
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '092399',
    database: 'easymall',
    timezone: 'Hongkong',
    charset: 'utf8',
});

connection.connect();
// User Path

/**
 * 查找登录用户
 * @param {Object} User 
 */
const login = ({username, password}) =>{
    let sql = `select * from user where username = '${username}' and password = '${password}'`;
    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

/**
 * 确认用户名可用
 * @param {Objcet} User
 */
const checkUserName = ({username}) =>{
    let sql = `select * from user where username = '${username}'`;
    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            let ans = result.length != 0;
            resolve(ans);
            return ans;
        });
    });
}

/**
 * 注册用户
 * @param {Object} User
 */
const register = ({username, password, nickname, email}) =>{
    let sql = `insert into user(id,username,password,nickname,email) values(null,'${username}','${password}','${nickname}',${email||'\'\''});`;
    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

// Product Path

/**
 * 所有商品信息
 */
const allcategorys = async () =>{
    let sql = `select distinct(category) from products`;
    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

/**
 *  根据输入条件查询商品信息
 * @param {Object} Products
 */
const prodlist = ({minPrice, maxPrice, name, category}) =>{
    let sql = `select * from products where (price between ${minPrice} and ${maxPrice} )`;
    if (name){
        sql += ` and name like concat('%','${name}','%')`
    }
    if (category){
        sql += ` and category=${category}`
    }

    sql += ' order by pnum desc';

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

/**
 * 显示商品详情 
 * @param {Object} Products
 */
const oneProduct = ({pid}) =>{
    let sql = `select * from products where id='${pid}'`;
    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });

}

/**
 * 分类显示
 * @param {Object} Products
 */
const proclass = ({category}) =>{
    let sql = `select * from products where category='${category}'`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

/**
 * 修改销量
 * @param {Object} Products
 */
const updatepnum = ({pnum, id}) =>{
    let sql = `update products set pnum = pnum + ${pnum} where id = '${id}'`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

// Order Path

/**
 * 添加Order表记录
 * @param {Object} Orders 
 */
const addOrder = ({id, money, receiverinfo, paystate, ordertime, user_id}) =>{
    let sql = `insert into orders(id,money,receiverinfo,paystate,ordertime,user_id)` + 
        ` values('${id}',${money},'${receiverinfo}',${paystate},'${ordertime}','${user_id}')`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

/**
 * 显示订单
 * @param {Object} Orders
 */
const findOrderByUserId = ({user_id}) =>{
    let sql = `select * from orders where user_id=${user_id}`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

/**
 * 删除订单
 * @param {Object} Orders
 */
const delorder = ({id}) =>{
    let sql = `delete from orders where id='${id}'`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

/**
 * 支付订单
 * @param {Object} Orders
 */
const payorder = ({id}) =>{
    let sql = `update orders set paystate=1 where id='${id}'`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

/**
 * 确认收货
 * @param {Object} Orders
 */
const confirmorder = ({id}) =>{
    let sql = `update orders set paystate=3 where id='${id}'`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

// OrderItem Path

/**
 * 添加OrderItem表记录
 * @param {Object} OrderItem
 */
const addOrderItem = ({order_id, product_id, buynum}) =>{
    let sql = `insert into orderitem(order_id,product_id,buynum)` + 
        ` values('${order_id}','${product_id}',${buynum})`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

/**
 * 显示订单 详细商品信息
 * @param {Object} OrderItem
 */
const orderitem = ({order_id}) =>{
    let sql = `select * from orderitem where order_id='${order_id}'`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

/**
 * 删除订单项
 * @param {Object} OrderItem
 */
const delorderitem = ({id}) =>{
    let sql = `delete from orderitem where order_id=${id}`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

// Cart Path

/**
 * 检查正要加入购物车的商品是否已在购物车中
 * @param {Object} Cart
 */
const findCart = ({user_id, pid}) =>{
    let sql = `select * from cart where user_id='${user_id}' and pid='${pid}'`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

/**
 * 添加商品到购物车
 * @param {Object} Cart
 */
const addCart = ({user_id, pid, num}) =>{
    let sql = `insert into cart(user_id,pid,num) values(${user_id},'${pid}',${num})`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

/**
 * 修改购物车商品数量
 * @param {Object} Cart
 */
const updateCart = ({num, cartID}) =>{
    let sql = `update cart set num=${num} where cartID='${cartID}'`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

/**
 * 修改购物车商品数量
 * @param {Object} Cart
 */
const updateBuyNum = ({num, cartID}) =>{
    let sql = `update cart set num=${num} where cartID=${cartID}`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

/**
 * 显示购物车
 * @param {Object} Cart
 */
const showCart = ({user_id}) =>{
    let sql = `select cartID,pid,num,name,price,imgurl from cart,products ` + 
        `where user_id=${user_id} and cart.pid=products.id`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}


/**
 * 删除购物车中商品
 * @param {Object} Cart
 */
const delCart = ({cartID}) =>{
    let sql = `delete from cart where cartID=${cartID}`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}


/**
 * 根据cartID查找购物车
 * @param {Object} Cart
 */
const findByCartID = ({cartID}) =>{
    let sql = `select cartID,pid,num,name,price,imgurl from cart,products` + 
        ` where cart.pid=products.id and cartID=${cartID}`;

    return new Promise( (resolve, reject) =>{

        connection.query(sql, (err, result) =>{
        
            if (err)
            {
                console.log('err: ', err);
                reject(err);
                return;
            }
            resolve(result);
            return result;
        });
    });
}

module.exports = {
    login, checkUserName, register,
    allcategorys, prodlist, oneProduct, proclass, updatepnum,
    addOrder, findOrderByUserId, delorder, payorder,confirmorder,
    addOrderItem, orderitem, delorderitem,
    findCart, addCart, updateCart, updateBuyNum, showCart, delCart, findByCartID,
}