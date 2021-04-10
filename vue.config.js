
module.exports = {
   devServer:{
       host: '0.0.0.0',
       port: 8080,
       open: true,
       proxy: {
           // detail: https://cli.vuejs.org/config/#devserver-proxy
           ['^/']: {
               target: `http://localhost:8081`,
               changeOrigin: true,
           }
       },
   }
}
