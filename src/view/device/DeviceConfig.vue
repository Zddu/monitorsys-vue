<template>
    <div>
        <div class="DMHeader">
            <div class="headerLeft">
                <div class="headerLeftTip">
                    检测总数
                    <a id="devconut">{{deviceTotal}}</a>个设备
                </div>
            </div>
            <div class="headerRight">
                <el-input size="small" style="width: 220px;margin-right: 10px;" v-model="searchIp" placeholder="输入IP搜索设备"></el-input>
                <el-button size="small" type="primary" plain icon="el-icon-search" @click="SearchIp()">搜索</el-button>
            </div>
        </div>
        <el-divider></el-divider>
        <div class="DMContent">
            <el-table
                    size="mini"
                    :data="tableData1"
                    style="width: 100%"
                    row-key="id"
                    height="500"
                    cell-click
                    :tree-props="{children: 'children', hasChildren: 'hasChildren'}">
                <el-table-column
                        prop="name"
                        label="名称"
                        node-key="id"
                        width="500">
                    <template class="custom-tree-node" slot-scope="scope">
                        <i :class="scope.row.icon"></i>
                        <span>{{scope.row.name}}</span>
                    </template>
                </el-table-column>
                <el-table-column
                        prop="typeName"
                        label="类型"
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="ip"
                        label="地址"
                >
                </el-table-column>
                <el-table-column
                        fixed="right"
                        label="操作"
                        width="200">
                    <template slot-scope="scope">
                        <el-button @click.stop="handleClick(scope.row)" type="text" size="small">编辑</el-button>
                        <el-button @click.stop="showDevice(scope.row)" type="text" size="small">查看</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>
        <el-dialog
                width="30%"
                style="align-items: center"
                title="编辑信息"
                :visible.sync="dialogFormVisible">
            <div>
                <el-form ref="form" :model="form" label-width="80px">
                    <el-form-item label="名称">
                        <el-input style="width: 70%" size="small" v-model="form.name" placeholder="输入设备名称"></el-input>
                    </el-form-item>
                    <el-form-item label="类型">
                        <el-select style="width: 70%" size="small" v-model="form.typeName" placeholder="选择设备类型">
                            <el-option label="路由器" value="路由器"></el-option>
                            <el-option label="服务器" value="服务器"></el-option>
                            <el-option label="三层交换机" value="三层交换机"></el-option>
                            <el-option label="二层交换机" value="二层交换机"></el-option>
                            <el-option label="未知设备" value="未知设备"></el-option>
                            <el-option label="SNMP服务未响应" value="SNMP服务配置有误"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="描述">
                        <el-input
                                size="small"
                                style="width: 70%"
                                type="textarea"
                                :rows="2"
                                placeholder="填写设备描述"
                                v-model="form.selfDecs">
                        </el-input>
                    </el-form-item>
                    <el-form-item label="IP地址">
                        <el-input style="width: 70%" :value=form.ip size="small" disabled
                                  placeholder="输入设备IP地址"></el-input>
                    </el-form-item>
                </el-form>
            </div>
            <div slot="footer" class="dialog-footer">
                <el-button size="small" @click="dialogFormVisible = false">取 消</el-button>
                <el-button size="small" type="primary" @click="updateDevice()">确 定</el-button>
            </div>
        </el-dialog>

        <el-dialog width="80%" :title="form.ip" :visible.sync="ischeck">
            <div>
                <el-row :gutter="10">
                    <el-col :span="9">
                        <div class="baseDevice">
                            <el-scrollbar :native="false"  wrapClass="selfbar" style="height: 100%;border: 1px solid #c8c8c8;border-radius: 2%;">
                                <table style="margin: 0 auto">
                                    <tr>
                                        <td style="padding: 5px">设备IP</td>
                                        <td style="padding: 5px">
                                            <el-tag :title="form.ip"
                                                    style="width: 180px;overflow: hidden; text-overflow: ellipsis; white-space:nowrap;"
                                                    size="medium"> {{form.ip}}
                                            </el-tag>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 5px">设备类型</td>
                                        <td style="padding: 5px">
                                            <el-tag :title="form.typeName"
                                                    style="width: 180px;overflow: hidden; text-overflow: ellipsis; white-space:nowrap;"
                                                    size="medium"> {{form.typeName}}
                                            </el-tag>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 5px">设备运行时长</td>
                                        <td style="padding: 5px">
                                            <el-tag :title="BaseInfo.sysUpTime"
                                                    style="width: 180px;overflow: hidden; text-overflow: ellipsis; white-space:nowrap;"
                                                    size="medium"> {{BaseInfo.sysUpTime}}
                                            </el-tag>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 5px">设备联系人</td>
                                        <td style="padding: 5px">
                                            <el-tag :title="BaseInfo.sysContact"
                                                    style="width: 180px;overflow: hidden; text-overflow: ellipsis; white-space:nowrap;"
                                                    size="medium"> {{BaseInfo.sysContact}}
                                            </el-tag>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 5px">设备机器名</td>
                                        <td style="padding: 5px">
                                            <el-tag :title="BaseInfo.sysName"
                                                    style="width: 180px;overflow: hidden; text-overflow: ellipsis; white-space:nowrap;"
                                                    size="medium"> {{BaseInfo.sysName}}
                                            </el-tag>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 5px">设备型号</td>
                                        <td style="padding: 5px">
                                            <el-tag :title="BaseInfo.sysDecsr"
                                                    style="width: 180px;overflow: hidden; text-overflow: ellipsis; white-space:nowrap;"
                                                    size="medium">{{BaseInfo.sysDecsr}}
                                            </el-tag>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 5px">设备名称</td>
                                        <td style="padding: 5px">

                                            <el-tag :title="BaseInfo.name"
                                                    style="width: 180px;overflow: hidden; text-overflow: ellipsis; white-space:nowrap;"
                                                    size="medium"> {{BaseInfo.name}}
                                            </el-tag>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 5px">设备位置</td>
                                        <td style="padding: 5px">
                                            <el-tag :title="BaseInfo.sysLocation"
                                                    style="width: 180px;overflow: hidden; text-overflow: ellipsis; white-space:nowrap;"
                                                    size="medium"> {{BaseInfo.sysLocation}}
                                            </el-tag>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 5px">描述</td>
                                        <td style="padding: 5px">
                                            <el-tag :title="BaseInfo.selfDecs"
                                                    style="width: 180px;overflow: hidden; text-overflow: ellipsis; white-space:nowrap;"
                                                    size="medium"> {{BaseInfo.selfDecs}}
                                            </el-tag>
                                        </td>
                                    </tr>
                                </table>
                            </el-scrollbar>
                        </div>
                    </el-col>
                    <el-col :span="15">
                        <el-row :gutter="10">
                            <el-col :span="24">
                                <CpuInfo id="cpu" :data="cpuData" :ip="form.ip"/>
                            </el-col>
                        </el-row>
                        <el-row :gutter="10">
                            <el-col :span="24">
                                <MemoryInfo id="mem" :data="memData" :ip="form.ip"/>
                            </el-col>
                        </el-row>
                    </el-col>
                </el-row>
                <el-row :gutter="10" style="margin-bottom: 5px;">
                    <el-col :span="24">
                        <IfFlow id="flow" :data="ifFlow" :ip="form.ip"/>
                    </el-col>
                </el-row>
                <el-row :gutter="10">
                    <el-col :span="24">
                        <IfInfo id="inter" :data="ifData" :ip="form.ip"/>
                    </el-col>
                </el-row>
            </div>
        </el-dialog>
    </div>
</template>

<script>

    import CpuInfo from "../../components/dev/CpuInfo";
    import MemoryInfo from "../../components/dev/MemoryInfo";
    import IfInfo from "../../components/dev/ifInfo";
    import IfFlow from "../../components/dev/ifFlow";

    export default {
        name: "DeviceConfig",
        components: {IfFlow, IfInfo, MemoryInfo, CpuInfo},
        data() {
            return {
                searchIp:'',
                BaseInfo: {},
                ifFlow: [],
                ifData: [],
                cpuData: {
                    cpuRate: [],
                    time: []
                },
                memData: {
                    cpuRate: [],
                    time: []
                },
                chart: '',
                option: '',
                tableData: [],
                ischeck: false,
                form: {
                    name: '',
                    typeName: '',
                    ip: '',
                    selfDecs:''
                },
                ip: '',
                deviceTotal: 0,
                dialogFormVisible: false,
                tableData1: [{
                    id: -1,
                    name: '设备容器',
                    typeName: '组',
                    icon: 'iconfont Moniconfuwuqi iconFirst',
                    children: [{
                        id: -11,
                        name: '服务器',
                        typeName: '组',
                        icon: 'iconfont Moniconwenjianjia iconSecond',
                        children: []
                    }, {
                        id: -12,
                        name: '网络设备',
                        typeName: '组',
                        icon: 'iconfont Moniconwenjianjia iconSecond',
                        children: []
                    }, {
                        id: -13,
                        name: '未知设备',
                        typeName: '组',
                        icon: 'iconfont Moniconwenjianjia iconSecond',
                        children: []
                    }, {
                        id: -14,
                        name: 'SNMP未响应',
                        typeName: '组',
                        icon: 'iconfont Moniconwenjianjia iconSecond',
                        children: []
                    }],
                }],
                options: [],
                value: ''
            }
        },
        methods: {
            getAllDevice() {
                this.getRequest("/device/disp").then(res => {
                    this.deviceTotal = res.length;
                    console.log(res);
                    for (let i in res) {
                        if (res[i].typeName === '服务器') {
                            this.tableData1[0].children[0].children.push(res[i]);
                        } else if (res[i].typeName === '未知设备') {
                            this.tableData1[0].children[2].children.push(res[i]);
                        } else if (res[i].typeName === 'SNMP服务配置有误') {
                            this.tableData1[0].children[3].children.push(res[i]);
                        } else {
                            this.tableData1[0].children[1].children.push(res[i]);
                        }
                    }
                });
            },
            handleClick(row) {
                if (row.id === -11 || row.id === -12 || row.id === -13 || row.id === -14 || row.id === -1) {
                    this.$message({
                        message: '目录文件夹不支持修改！',
                        type: 'warning'
                    });
                } else {
                    this.form.typeName=row.typeName;
                    this.form.name=row.name;
                    this.form.selfDecs=row.selfDecs;
                    this.form.ip = row.ip;
                    this.dialogFormVisible = true;
                }
            },
            updateDevice() {
                this.putRequest("/device/disp", this.form).then(res => {
                    this.dialogFormVisible = false;
                    this.tableData1[0].children[0].children = [];
                    this.tableData1[0].children[1].children = [];
                    this.tableData1[0].children[2].children = [];
                    this.tableData1[0].children[3].children = [];
                    this.getAllDevice();
                })
            },
            showDevice(row) {
                if (row.id === -11 || row.id === -12 || row.id === -13 || row.id === -14 || row.id === -1) {
                    this.$message({
                        message: '目录文件夹不支持查看！',
                        type: 'warning'
                    });
                } else {
                    this.form.ip = row.ip;
                    this.form.name = row.name;
                    this.form.typeName = row.typeName;
                    this.form.selfDecs = row.selfDecs;
                    this.ischeck = true;
                    this.initCpu();
                    this.initMem();
                    this.initif();
                    this.initFlow();
                    this.initBase();
                }
            },
            initCpu() {
                this.getRequest("/monitor/cpu/one/" + this.form.ip).then(res => {
                    this.cpuData.time = [];
                    this.cpuData.cpuRate = [];
                    this.cpuData.time.push(res.time);
                    this.cpuData.cpuRate.push(res.cpuRate);
                });
            },
            initMem() {
                this.getRequest("/memory/one/" + this.form.ip).then(res => {
                    this.memData.time = [];
                    this.memData.memRate = [];
                    this.memData.time.push(res.time);
                    this.memData.memRate.push(res.cpuRate);
                });
            },
            initif() {
                this.getRequest("/monitor/base/" + this.form.ip).then(res => {
                    for (let i in res) {
                        if (res[i].ifOperStatus === "1") {
                            res[i].ifOperStatus = '开启'
                        } else {
                            res[i].ifOperStatus = '关闭'
                        }
                        if (res[i].ifAdminStatus === "1") {
                            res[i].ifAdminStatus = '开启'
                        } else {
                            res[i].ifAdminStatus = '关闭'
                        }
                    }
                    this.ifData = res;
                })
            },
            initFlow() {
                this.getRequest("/monitor/flow/" + this.form.ip).then(res => {
                    this.ifFlow = res;
                })
            },
            initBase() {
                this.getRequest("/monitor/dev/" + this.form.ip).then(res => {
                    this.BaseInfo = res;
                })
            },
            SearchIp(){
                // this.getRequest("monitor/search/"+this.searchIp).then(res=>{
                //
                // })
            }
        },

        mounted() {
            this.getAllDevice();
        }
    }
</script>

<style>
    .selfbar{
        overflow-x: hidden!important;
    }
    .baseDevice {
        text-align: center;
        height: 350px;
        margin-bottom: 5px;
        border: #eaeaea;
        border-radius: 5px;
    }


    .DMHeader {
        height: 58px;
        padding: 15px 30px 10px 20px;
        background-color: #edeef3 !important;
        box-sizing: border-box;
        width: 100%;
    }

    .headerLeft {
        float: left;
        margin-left: 10px;
        margin-top: 5px;
        height: 19px;
        line-height: 19px;
    }

    .headerLeftTip {
        float: left;
        font-size: 14px;
        margin-right: 40px;
    }

    #devconut {
        color: #3c8dbc;
        text-decoration: none;
    }

    .devcount {
        margin-right: 30px;
    }

    #moncount {
        color: #eb5d5d;
        text-decoration: none;
    }

    .st-square {
        margin-right: 6px;
        width: 9px;
        height: 9px;
        display: inline-block;
    }

    .st-square-green {
        cursor: pointer;
        background-color: #3db58d;
    }

    .st-square-orange {
        cursor: pointer;
        background-color: orange;
    }

    .st-square-red {
        cursor: pointer;
        background-color: red;
    }

    .st-square-grey {
        cursor: pointer;
        background-color: grey;
    }

    .st-square-black {
        cursor: pointer;
        background-color: black;
    }

    #count1, #count2, #count3, #count4, #count5 {
        color: #3c8dbc;
        line-height: 19px;
    }

    .headerRight {
        float: right;
        margin-left: 10px;
        height: 32px;
        display: flex;
        width: 650px;
    }

    #searchedevice {
        height: 19px;
        line-height: 19px;
        display: flex;
    }

    #searchedevice i {
        margin-top: 7px;
        margin-right: 10px;
    }

    .el-divider--horizontal {
        margin: 12px 0px;
        box-sizing: border-box;
    }

    .DMContent {
        background-color: white;
        margin: 0 auto;
        box-sizing: border-box;
    }

    .iconFirst {
        margin-right: 5px;
        color: green;
    }

    .iconSecond {
        margin-right: 5px;
        color: red;
    }

    .iconThird {
        margin-right: 5px;
        color: green;
    }
    .unknownD{
        font-size: 16px;
        color: #ffc610;
    }
    .snmpNot{
        font-size: 16px;
        color: #ff1407;
    }
    .tab-content {
        box-sizing: border-box;
    }

    .bar-header {
        border-top: 0;
        margin: 30px 0px 10px;
        padding: 20px 0px 10px 60px;
    }

    .bar-header .header-pre {
        margin-right: 4px;
        background-color: #666666;
        width: 4px;
        height: 20px;
        display: inline-block;
    }

    .bar-header span {
        vertical-align: middle;
        display: inline-block;
        padding-bottom: 2px;
        font-family: 微软雅黑;
        font-size: 20px;
        font-weight: normal;
        font-style: normal;
        text-decoration: none;
        color: #666666;
    }
</style>
