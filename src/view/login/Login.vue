<template>
    <div id="login">
        <div>
            <el-form label-width="60px" :rules="rules" :model="loginForm" ref="loginForm" class="loginForm" :label-position="labelPosition">
                <h3 class="loginTitle">监控系统用户登录</h3>
                <el-form-item prop="username" label="账户">
                    <el-input type="text" v-model="loginForm.username" auto-complete="off" placeholder="请输入用户名"></el-input>
                </el-form-item>
                <el-form-item prop="password" label="密码">
                    <el-input type="password" v-model="loginForm.password" @keydown.enter.native="submitForm" auto-complete="off" placeholder="请输入密码"></el-input>
                </el-form-item>
                <el-checkbox v-model="checked" style="margin-bottom: 10px">记住密码</el-checkbox>
                <el-button style="width: 100%" type="primary"  @click="submitForm">登陆</el-button>
                <div class="tip">
                    提示: 为了获得更好的体验建议使用IE 11、谷歌或火狐浏览器进行管理。
                </div>
            </el-form>
        </div>
    </div>
</template>

<script>

    export default {
        name: "Login",
        data() {
            return {
                labelPosition: 'right',
                loginForm: {
                    username: 'admin',
                    password: '123'
                },
                checked:false,
                rules: {
                    username: [{required: true, message: "请输入用户名", trigger: 'blur'}],
                    password: [{required: true, message: "请输入密码", trigger: 'blur'}],
                },
            }
        },
        methods:{
            submitForm(){
                this.$router.push('/home');
                this.$refs.loginForm.validate((valid) => {
                    if (valid) {
                        this.postRequest('/monitor/doLogin',this.loginForm).then(resp=>{ //这里的resp 里面返回就是api.js 里面处理过的
                            //这里直接判断 resp 是否为空  如果为空不用处理 api里面已经处理过了，只需要处理成功的即可
                            if(resp){
                                window.sessionStorage.setItem("user",JSON.stringify(resp.obj));
                                let path = this.$route.query.redirect;
                                console.log(this.$route.query.redirect);
                                this.$router.replace((path === '/' || path === undefined) ? '/home' : path);//replace 方法替换当前页 为home，不可以返回，push方法则可以返回到登录页
                            }
                        })
                    } else {
                        this.$message({
                            message: '请填写必要信息！',
                            type: 'warning'
                        });
                        return false;
                    }
                });
            }
        }
    }
</script>

<style>
    #login{
        width: 100%;
        height: 100%;
        background-image: url('./images/login_bg.png') !important;
        background-repeat: no-repeat;
        background-size: 100% 100%;
        background-attachment: fixed;
        background-color: #8ea09f;
        font-size: 12px;
        color: #333;
        overflow:hidden
    }
    .loginForm{
        border-radius: 15px;
        margin: 180px auto;
        width: 400px;
        /*上右下左*/
        padding: 25px 35px 35px 35px ;
        background: #fff;
        border: 1px solid #eaeaea;
        box-shadow: 0 0 25px #eaeaea;
    }
    .loginTitle{
        margin: 15px auto 15px auto;
        text-align: center;
        color: #15a06c;
    }
    .tip{
        margin-top: 10px;
    }
</style>
