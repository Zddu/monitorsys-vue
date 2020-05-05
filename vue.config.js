let proxyObj = {};
proxyObj['/ws'] = {
  ws:true,
  target: "ws://localhost:8081"
};
proxyObj['/'] = {
    ws: false,
    target: 'http://localhost:8081',
    pathRewrite: {
        '^/': ''
    }
}
module.exports = {
    devServer:{
        host:'localhost',
        port:8080,
        proxy:proxyObj
    }
}