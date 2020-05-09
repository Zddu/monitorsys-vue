<template>

    <el-container>
        <el-header class="homeContainer">
            <span class="title">监控管理系统</span>
            <div>
                <el-button icon="el-icon-bell" type="text" style="margin-right:10px;"></el-button>
                <el-dropdown trigger="click">
                    <span class="el-dropdown-link">
                        name<i class="el-icon-user-solid" style="margin-left: 8px;font-size: 20px"></i>
                    </span>
                    <el-dropdown-menu slot="dropdown">
                        <el-dropdown-item command="userinfo">个人中心</el-dropdown-item>
                        <el-dropdown-item command="setting">设置</el-dropdown-item>
                        <el-dropdown-item command="modify">修改密码</el-dropdown-item>
                        <el-dropdown-item command="logout" divided>安全退出</el-dropdown-item>
                    </el-dropdown-menu>
                </el-dropdown>
            </div>
        </el-header>
        <el-container>
            <el-aside width="200px;" style="height: 100%;">
                <el-menu
                        class="el-menu-vertical-demo"
                        background-color="#1e2640"
                        text-color="#fff"
                        unique-opened
                        router
                        active-text-color="#ffd04b">
                    <el-submenu index="1">
                        <template slot="title">
                            <i class="el-icon-s-data"></i>
                            <span>全局总览</span>
                        </template>
                        <el-menu-item index="/home">仪表盘</el-menu-item>
                    </el-submenu>
                    <el-submenu index="2">
                        <template slot="title">
                            <i class="el-icon-s-platform"></i>
                            <span>设备监控</span>
                        </template>
                        <el-menu-item index="/deviceManage">
                            设备管理
                        </el-menu-item>
                        <el-menu-item index="/devDis">
                            硬件管理
                        </el-menu-item>
                        <el-menu-item index="/devForm">
                            流量展示
                        </el-menu-item>
                    </el-submenu>
                    <el-submenu index="7">
                        <template slot="title">
                            <i class="el-icon-s-cooperation"></i>
                            <span>故障管理</span>
                        </template>
                        <el-menu-item index="/ruleset">
                            规则设置
                        </el-menu-item>
                        <el-menu-item index="/failureAll">
                            故障总览
                        </el-menu-item>
                        <el-menu-item index="/failAnalysis">
                            故障分析
                        </el-menu-item>
                        <el-menu-item index="/faultManage">
                            故障视图
                        </el-menu-item>
                        <el-menu-item index="/hitchRequire">
                            故障查询
                        </el-menu-item>
                        <el-menu-item index="/trap">
                            TRAP日志
                        </el-menu-item>
                    </el-submenu>
                    <el-submenu index="3">
                        <template slot="title">
                            <i class="el-icon-s-marketing"></i>
                            <span>网络拓扑</span>
                        </template>
                        <el-menu-item index="3-1">视图展示</el-menu-item>
                        <el-menu-item index="3-2">图表展示</el-menu-item>
                    </el-submenu>
                    <el-submenu index="8">
                        <template slot="title">
                            <i class="el-icon-data-analysis"></i>
                            <span>流量分析</span>
                        </template>
                        <el-menu-item index="3-1">视图展示</el-menu-item>
                        <el-menu-item index="3-2">图表展示</el-menu-item>
                    </el-submenu>
                    <el-submenu index="4">
                        <template slot="title">
                            <i class="el-icon-setting"></i>
                            <span>日志监控</span>
                        </template>
                        <el-menu-item index="4-1">系统日志</el-menu-item>
                        <el-menu-item index="4-2">Trap日志</el-menu-item>
                    </el-submenu>
                    <el-submenu index="5">
                        <template slot="title">
                            <i class="el-icon-menu"></i>
                            <span>配置管理</span>
                        </template>
                        <el-menu-item index="5-1">
                            ip地址管理
                        </el-menu-item>
                    </el-submenu>
                    <el-submenu index="6">
                        <template slot="title">
                            <i class="el-icon-s-tools"></i>
                            <span>系统设置</span>
                        </template>
                        <el-menu-item index="6-1">
                            用户权限
                        </el-menu-item>
                        <el-menu-item index="6-1">
                            告警设置
                        </el-menu-item>
                    </el-submenu>
                </el-menu>
            </el-aside>
            <el-scrollbar  class="default-scrollbar" wrap-class="default-scrollbar__wrap" view-class="p20-scrollbar__view" :native="false">
                <el-main style="height: 100%;">
                <el-breadcrumb style="margin-bottom: 10px;" separator="/"
                               v-if="this.$router.currentRoute.path !='/home'">
                    <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item>{{this.$router.currentRoute.name}}</el-breadcrumb-item>
                </el-breadcrumb>
                <div v-if="this.$router.currentRoute.path =='/home'">
                    <overall/>
                </div>
                <router-view/>
            </el-main>
            </el-scrollbar>
        </el-container>
    </el-container>

</template>

<script>
    import overall from "./overall/overall";

    export default {
        name: "Home",
        components: {
            overall,
        },
        data() {
            return {}
        },
        computed: {},
        methods: {}
    }
</script>

<style>
    .el-scrollbar__wrap.default-scrollbar__wrap {
        overflow-x: auto;
    }
    .default-scrollbar {
        width: 100%;
        height: 100%;
    }
    .flex-scrollbar {
        width: auto;
        height: auto;
        -webkit-box-flex: 1;
        -ms-flex: 1;
        flex: 1;
    }
    .el-scrollbar__wrap.default-scrollbar__wrap {
        overflow-x: auto;
    }
    .el-aside {
        background-color: rgb(30, 38, 64);
        color: #333;
        text-align: center;
        line-height: 200px;
    }


    body > .el-container {
        margin-bottom: 40px;
    }

    .el-container .el-aside {
        line-height: 260px;
    }

    #app, .el-container {
        height: 100%;
    }

    .homeContainer {
        background-color: #111;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 25px;
        box-sizing: border-box;
    }

    .homeContainer .title {
        color: #fff;
        font-size: 20px;
        line-height: 50px;
        width: 200px;
        transition: background-color ease .3s;
    }

    .el-dropdown-link {
        cursor: pointer;
        color: #ccc;
        font-size: 16px;
        display: flex;
        align-items: center;
    }

    .el-dropdown-link img {
        width: 40px;
        height: 40px;
        border-radius: 30px;
        margin-left: 10px;
    }

    .box-card {
        margin-bottom: 10px;
    }

</style>
