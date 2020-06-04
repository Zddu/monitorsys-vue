<template>
    <div>
        <el-row :gutter="5">
            <el-col :span="8">
                <el-scrollbar class="default_scrollbar" wrap-class="default_scrollbar__wrap">
                    <div class="device">
                        <el-button @click="getBtn(item.ip)" class="item" v-for="(item) in device">
                            <img class="item_img" :src="item.imgsrc" alt="二层交换机" title="二层交换机">
                            <span class="item_specify">{{item.name}}</span>
                            <span class="item_ip">{{item.ip}}</span>
                        </el-button>
                    </div>
                </el-scrollbar>
            </el-col>
            <el-col :span="16">
                <el-row :gutter="5">
                    <el-col :span="12">
                        <el-scrollbar class="default_scrollbar tab_scorll" >
                            <div class="base">
                                <table class="tab">
                                    <tr style="height: 40px;">
                                        <td>设备型号</td>
                                        <td class="tdSec">Cisco IOS Software, C3560 Software (C3560-IPSERVICES-M), Version 12.2(50)SE1, RELEASE SOFTWARE (fc2)
                                            Copyright (c) 1986-2009 by Cisco Systems, Inc.
                                            Compiled Mon 06-Apr-09 02:26 by amvarma </td>
                                    </tr>
                                    <tr style="height: 40px;">
                                        <td>设备描述</td>
                                        <td class="tdSec">
                                            长庚楼汇聚交换机
                                        </td>
                                    </tr>
                                    <tr style="height: 40px;">
                                        <td>设备名称</td>
                                        <td class="tdSec">sw1</td>
                                    </tr>
                                    <tr style="height: 40px;">
                                        <td>设备运行时长</td>
                                        <td class="tdSec">7day，8:35:33:2</td>
                                    </tr>
                                    <tr style="height: 40px;">
                                        <td>远程登录密码</td>
                                        <td class="tdSec">******</td>
                                    </tr>
                                </table>
                            </div>
                        </el-scrollbar>
                    </el-col>
                    <el-col :span="12">
                        <el-table
                                size="small"
                                :data="diskData"
                                border
                                height="270"
                                >
                            <el-table-column
                                    prop="diskName"
                                    label="磁盘名"
                                    width="60"
                                   >
                            </el-table-column>
                            <el-table-column
                                    prop="capacity"
                                    label="容量(MB)"
                                    >
                            </el-table-column>
                            <el-table-column
                                    prop="used"
                                    label="已使用(MB)"
                            >
                            </el-table-column>
                            <el-table-column
                                    prop="time"
                                    label="获取时间">
                            </el-table-column>
                        </el-table>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="24">
                        <el-table
                                size="small"
                                :data="interData"
                                border
                                height="300"
                                style="width: 100%">
                            <el-table-column
                                    prop="IfDescr"
                                    label="名称"
                                    width="180">
                            </el-table-column>
                            <el-table-column
                                    prop="status"
                                    label="状态"
                                    width="80">
                            </el-table-column>
                            <el-table-column
                                    prop="ip"
                                    label="接口IP"
                            >
                            </el-table-column>
                            <el-table-column
                                    prop="IfFlow"
                                    label="接口流量(Kbits/s)">
                            </el-table-column>
                            <el-table-column
                                    prop="time"
                                    label="获取时间">
                            </el-table-column>
                            <el-table-column
                                    fixed="right"
                                    label="操作"
                                    width="100">
                                <template slot-scope="scope">
                                    <el-button @click="handleClick(scope.row)" type="text" size="small">查看更多</el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                    </el-col>
                </el-row>
            </el-col>
        </el-row>
    </div>
</template>

<script>
    export default {
        name: "DevBaseInfo",
        data() {
            return {
                interData: [
                    {
                        IfDescr: 'FastE:0/0',
                        status: '开启',
                        ip: '172.17.137.60',
                        IfFlow: '203.1',
                        time: '2020/5/15/08:00'
                    }, {
                        IfDescr: 'FastE:0/0',
                        status: '开启',
                        ip: '172.17.137.60',
                        IfFlow: '203.1',
                        time: '2020/5/15/08:00'
                    }, {
                        IfDescr: 'FastE:0/0',
                        status: '开启',
                        ip: '172.17.137.60',
                        IfFlow: '203.1',
                        time: '2020/5/15/08:00'
                    }, {
                        IfDescr: 'FastE:0/0',
                        status: '开启',
                        ip: '172.17.137.60',
                        IfFlow: '203.1',
                        time: '2020/5/15/08:00'
                    }, {
                        IfDescr: 'FastE:0/0',
                        status: '开启',
                        ip: '172.17.137.60',
                        IfFlow: '203.1',
                        time: '2020/5/15/08:00'
                    }, {
                        IfDescr: 'FastE:0/0',
                        status: '开启',
                        ip: '172.17.137.60',
                        IfFlow: '203.1',
                        time: '2020/5/15/08:00'
                    }, {
                        IfDescr: 'FastE:0/0',
                        status: '开启',
                        ip: '172.17.137.60',
                        IfFlow: '203.1',
                        time: '2020/5/15/08:00'
                    }, {
                        IfDescr: 'FastE:0/0',
                        status: '开启',
                        ip: '172.17.137.60',
                        IfFlow: '203.1',
                        time: '2020/5/15/08:00'
                    }, {
                        IfDescr: 'FastE:0/0',
                        status: '开启',
                        ip: '172.17.137.60',
                        IfFlow: '203.1',
                        time: '2020/5/15/08:00'
                    },
                ],
                device: [
                    {
                        imgsrc: require('../../assets/img/twoswitch.png'),
                        name: '交换机',
                        ip: '172.17.137.60'
                    }, {
                        imgsrc: require('../../assets/img/huijuswitch.png'),
                        name: '交换机',
                        ip: '172.17.137.126'
                    }, {
                        imgsrc: require('../../assets/img/router.png'),
                        name: '路由器',
                        ip: '172.17.137.115'
                    }, {
                        imgsrc: require('../../assets/img/server.png'),
                        name: '服务器',
                        ip: '172.17.136.86'
                    }, {
                        imgsrc: require('../../assets/img/twoswitch.png'),
                        name: '交换机',
                        ip: '172.17.137.60'
                    }, {
                        imgsrc: require('../../assets/img/huijuswitch.png'),
                        name: '交换机',
                        ip: '172.17.137.126'
                    }, {
                        imgsrc: require('../../assets/img/router.png'),
                        name: '路由器',
                        ip: '172.17.137.115'
                    }, {
                        imgsrc: require('../../assets/img/server.png'),
                        name: '服务器',
                        ip: '172.17.136.86'
                    }, {
                        imgsrc: require('../../assets/img/twoswitch.png'),
                        name: '交换机',
                        ip: '172.17.137.60'
                    }, {
                        imgsrc: require('../../assets/img/huijuswitch.png'),
                        name: '交换机',
                        ip: '172.17.137.126'
                    }, {
                        imgsrc: require('../../assets/img/router.png'),
                        name: '路由器',
                        ip: '172.17.137.115'
                    }, {
                        imgsrc: require('../../assets/img/server.png'),
                        name: '服务器',
                        ip: '172.17.136.86'
                    }, {
                        imgsrc: require('../../assets/img/twoswitch.png'),
                        name: '交换机',
                        ip: '172.17.137.60'
                    }, {
                        imgsrc: require('../../assets/img/huijuswitch.png'),
                        name: '交换机',
                        ip: '172.17.137.126'
                    }, {
                        imgsrc: require('../../assets/img/router.png'),
                        name: '路由器',
                        ip: '172.17.137.115'
                    }, {
                        imgsrc: require('../../assets/img/server.png'),
                        name: '服务器',
                        ip: '172.17.136.86'
                    }, {
                        imgsrc: require('../../assets/img/twoswitch.png'),
                        name: '交换机',
                        ip: '172.17.137.60'
                    }, {
                        imgsrc: require('../../assets/img/huijuswitch.png'),
                        name: '交换机',
                        ip: '172.17.137.126'
                    }, {
                        imgsrc: require('../../assets/img/router.png'),
                        name: '路由器',
                        ip: '172.17.137.115'
                    }, {
                        imgsrc: require('../../assets/img/server.png'),
                        name: '服务器',
                        ip: '172.17.136.86'
                    }, {
                        imgsrc: require('../../assets/img/twoswitch.png'),
                        name: '交换机',
                        ip: '172.17.137.60'
                    }, {
                        imgsrc: require('../../assets/img/huijuswitch.png'),
                        name: '交换机',
                        ip: '172.17.137.126'
                    }, {
                        imgsrc: require('../../assets/img/router.png'),
                        name: '路由器',
                        ip: '172.17.137.115'
                    }, {
                        imgsrc: require('../../assets/img/server.png'),
                        name: '服务器',
                        ip: '172.17.136.86'
                    }, {
                        imgsrc: require('../../assets/img/twoswitch.png'),
                        name: '交换机',
                        ip: '172.17.137.60'
                    }, {
                        imgsrc: require('../../assets/img/huijuswitch.png'),
                        name: '交换机',
                        ip: '172.17.137.126'
                    }, {
                        imgsrc: require('../../assets/img/router.png'),
                        name: '路由器',
                        ip: '172.17.137.115'
                    }, {
                        imgsrc: require('../../assets/img/server.png'),
                        name: '服务器',
                        ip: '172.17.136.86'
                    },],
                diskData:[
                    {
                        diskName: 'C:/',
                        capacity: '100000',
                        used: '23001',
                        time: '2020/5/15/08:00'
                    }, {
                        diskName: 'E:/',
                        capacity: '500000',
                        used: '120012',
                        time: '2020/5/15/08:00'
                    }, {
                        diskName: 'D:/',
                        capacity: '100000',
                        used: '23001',
                        time: '2020/5/15/08:00'
                    }, {
                        diskName: 'C:/',
                        capacity: '100000',
                        used: '23001',
                        time: '2020/5/15/08:00'
                    },
                ]
            }
        },
        methods: {
            handleClick() {

            },
            getBtn(ip) {
                console.log(ip);
            }
        }
    }
</script>

<style>
    .base {
        width: 100%;
        height: 270px;
        table-layout: fixed;
        box-sizing: border-box;
    }

    .base .tab {
        text-align: center;
        width: 100%;
    }
    .tab_scorll{
        margin-bottom: 10px;
    }
    .base .tab td {
        border-bottom: 1px solid #e6e4e0;
        border-right: 1px solid #e6e4e0;
        box-sizing: border-box;
    }

    .base .tab .tdSec {
        border-right: none;
        word-break: break-all;
        width: 50%;
    }

    .device {
        padding: 10px;
        height: 560px;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        align-content: flex-start;
    }

    .default_scrollbar {
        border: 1px solid #e6e4e0;
    }

    .el-scrollbar__wrap.default-scrollbar__wrap {
        overflow-x: auto;
    }

    .device .item {
        position: relative;
        width: 100px;
        height: 100px;
        margin: 0 0 10px 0 !important;
    }

    .device .item_img {
        width: 40px;
        height: 40px;
        position: absolute;
        top: 8px;
        left: 26px;
    }

    .device .item_specify {
        position: absolute;
        bottom: 10px;
        left: 27px;
    }

    .device .item_ip {
        position: absolute;
        left: 0;
        bottom: 27px;
    }
</style>
