<template>
    <el-container direction="vertical" style="width:100%;">
        <el-container style="width:100%;display: flex;">
            <div style="flex:1;">

                <div class="HRContent">
                    <div class="HRContentTabs">
                        <span style="float: left;margin-top: 3px;margin-right: 30px;font-family: 微软雅黑;font-size: 25px;display: block">故障查询</span>
                        <el-date-picker
                                size="small"
                                v-model="dateSelect"
                                type="datetimerange"
                                :picker-options="dateOptions"
                                range-separator="至"
                                start-placeholder="开始日期"
                                end-placeholder="结束日期"
                                align="right">
                        </el-date-picker>
                    </div>
                    <div class="HRTable" style="margin-top: 20px;">
                        <el-table
                                ref="multipleTable"
                                :data="hrtableData"
                                height="500"
                                size="mini"
                                tooltip-effect="dark"
                                style="width: 100%"
                        >
                            <el-table-column
                                    prop="rank"
                                    label="级别"
                                    width="170">
                                <template slot-scope="scope">
                                    <span class="st-square st-square-red"></span>
                                    <span>{{ scope.row.rank }}</span>
                                </template>
                            </el-table-column>
                            <el-table-column
                                    prop="device"
                                    label="设备名称"
                                    width="180">
                            </el-table-column>
                            <el-table-column
                                    prop="monitoring"
                                    label="检测点"
                                    width="180"
                            >
                            </el-table-column>
                            <el-table-column
                                    prop="number"
                                    label="次数"
                                    width="170">
                            </el-table-column>
                            <el-table-column
                                    prop="time2"
                                    label="开始时间"
                                   >
                            </el-table-column>
                            <el-table-column
                                    prop="time1"
                                    label="持续时间"
                                   >
                                <template slot-scope="scope">
                                    <div :class="scope.row.bgColor">
                                        {{ scope.row.time1 }}
                                    </div>
                                </template>
                            </el-table-column>
                            <el-table-column
                                    prop="detailed"
                                    label="详细"
                                    type="expand"
                                    width="120">
                                <template slot-scope="props">
                                    <el-form label-position="left" inline class="demo-table-expand">
                                        <el-form-item label="故障原因">
                                            <span>{{ props.row.cause }}</span>
                                        </el-form-item>
                                    </el-form>
                                </template>
                            </el-table-column>
                        </el-table>
                    </div>
                </div>
                <el-dialog title="查询时间" :visible.sync="hrDialogFormVisible">
                    <el-form :model="form">
                        <el-form-item label="开始日期" :label-width="hrFormLabelWidth">
                            <el-date-picker
                                    v-model="day1"
                                    type="date"
                            >
                            </el-date-picker>
                        </el-form-item>
                        <el-form-item label="结束日期" :label-width="hrFormLabelWidth">
                            <el-date-picker
                                    v-model="day1"
                                    type="date"
                            >
                            </el-date-picker>
                        </el-form-item>
                        <el-form-item label="监测点" :label-width="hrFormLabelWidth">
                            <div :class="[isChange?'treeContainer':'treeContainer-active']">
                                <el-tree @node-expand="hrExpand" @node-collapse="hrCollapse"
                                         :render-content="renderContent" show-checkbox :data="hrTreedata"
                                         :props="hrDefaultProps">
                                </el-tree>
                            </div>
                        </el-form-item>
                    </el-form>
                    <div slot="footer" class="dialog-footer">
                        <el-button size="small" @click="hrDialogFormVisible = false">取 消</el-button>
                        <el-button size="small" type="primary" @click="hrDialogFormVisible = false">确 定</el-button>
                    </div>
                </el-dialog>
            </div>
        </el-container>
    </el-container>
</template>

<script>
    export default {
        name: "HitchRequire",
        components: {
        },
        data() {
            return {
                dateSelect:[new Date(new Date().getFullYear(),new Date().getMonth(),new Date().getDay(),0,0), new Date(new Date().getFullYear(),new Date().getMonth(),new Date().getDay(),23, 0)],
                hrRadio: '今天',
                hrDialogFormVisible: false,
                hrFormLabelWidth: '120px',
                isChange: true,
                hrtableData: [{
                    rank: "(未处理)",
                    device: '综合信息管理',
                    monitoring: '物理内存',
                    number: "201",
                    time1: "1天8小时37分钟",
                    time2: "2020-04-17 02:56:58",
                    time3: "2020-04-17 02:56:58",
                    detailed: "详细",
                    operation: "操作",
                    bgColor: "st-square-red",
                    cause: "ConnectServer failed,服务器不可用，请确认您的主机是否正确！"
                }],
                hrTreedata: [{
                    label: '本机容器',
                    icon: 'iconfont Moniconrongqi iconFirst',
                    children: [{
                        label: '北京服务器',
                        icon: 'iconfont Moniconwenjianjia iconSecond',
                        children: [{
                            label: '智盘服务器10.1.1.50',
                            icon: 'iconfont Moniconfuwuqi iconThird',
                        }]
                    },
                        {
                            label: '北京服务器',
                            icon: 'iconfont Moniconwenjianjia iconSecond',
                            children: [{
                                label: '智盘服务器10.1.1.50',
                                icon: 'iconfont Moniconfuwuqi iconThird',
                            }]
                        }
                    ]
                }],
                hrDefaultProps: {
                    children: 'children',
                    label: 'label'
                },
                dateOptions: {
                    shortcuts: [{
                        text: '最近一周',
                        onClick(picker) {
                            const end = new Date();
                            const start = new Date();
                            start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
                            picker.$emit('pick', [start, end]);
                        }
                    }, {
                        text: '最近一个月',
                        onClick(picker) {
                            const end = new Date();
                            const start = new Date();
                            start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
                            picker.$emit('pick', [start, end]);
                        }
                    }, {
                        text: '最近三个月',
                        onClick(picker) {
                            const end = new Date();
                            const start = new Date();
                            start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
                            picker.$emit('pick', [start, end]);
                        }
                    }]
                },
                form: {
                    delivery: false,
                },
            }
        },
        computed: {
            day1() {
                return Date.now();
            }
        },
        methods: {
            flushCom: function () {
                this.reload();
            },
            agreeChange: function (val) {
                if (val === '自定义') {
                    this.hrDialogFormVisible = true;
                }
            },
            renderContent(h, {node, data, store}) {
                return (
                    < span >
                    < i class= {data.icon} > < /i>
                    < span > {node.label} < /span>
                    < /span>)
            },
            hrExpand(data) {
                if (data.label === '本机容器') {
                    this.isChange = false;
                }
            },
            hrCollapse(data) {
                if (data.label === '本机容器') {
                    this.isChange = true;
                }
            }
        }
    }
</script>

<style scoped>
    .HRHeader {
        height: 58px;
        padding: 15px 30px 10px 20px;
        box-sizing: border-box;
        width: 100%;
    }

    .HRHeaderRight {
        float: right;
        margin-left: 10px;
        height: 40px;
        display: flex;
        width: 250px;
        justify-content: space-around;
    }

    .btn {
        border-radius: 4px;
        line-height: 22px;
        font-size: 12px;
        padding: 0 10px;
        margin: 0 5px;
        -webkit-box-shadow: none;
        box-shadow: none;
        border: 1px solid transparent;
        display: inline-block;
        font-weight: 400;
        text-align: center;
        white-space: nowrap;
        vertical-align: middle;
        touch-action: manipulation;
        cursor: pointer;
        user-select: none;
        background-image: none;
    }

    .btn-black {
        background-color: #414852;
        border-color: #414852;
        color: #fff;
    }

    .btn-default {
        background-color: #fff;
        color: #444;
        border-color: #ddd;
    }

    .el-divider--horizontal {
        margin: 12px 0px;
        box-sizing: border-box;
    }


    .demo-table-expand {
        font-size: 0;
    }

    .demo-table-expand label {
        width: 90px;
        color: #99a9bf;
    }

    .demo-table-expand .el-form-item {
        margin-right: 0;
        margin-bottom: 0;
        width: 100%;
    }

    .treeContainer {
        width: 220px;
        height: 30px;
        border: 1px solid rgb(220, 223, 230);
        border-radius: 4px;
        margin-top: 5px;
        overflow: hidden;
    }

    .treeContainer-active {
        width: 220px;
        height: 70px;
        border: 1px solid rgb(220, 223, 230);
        border-radius: 4px;
        margin-top: 5px;
        overflow: auto;
    }

    .HRTable {
        background-color: white;
        margin: 0 auto;
        box-sizing: border-box;
    }


</style>
