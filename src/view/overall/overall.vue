<template>
    <div style="width: 100%">
        <el-row style="width: 100%" type="flex" class="row-bg" justify="space-around">
            <el-col :span="10">
                <div style="margin: 10px">
                    <el-card shadow="hover" >
                        <div slot="header">
                            <span>故障统计</span>
                        </div>
                        <div class="item">
                            <div id="over" style="width: 100%;height: 300px"></div>
                        </div>
                    </el-card>

                    <el-card style="margin-top: 10px;" shadow="hover" >
                        <div slot="header">
                            <span>设备统计(设备总数{{deviceTotal}})</span>
                        </div>
                        <div class="item">
                            <div id="over1" style="width: 100%;height: 300px"></div>
                        </div>
                    </el-card>
                </div>
            </el-col>
            <el-col :span="10">
                <div style="margin: 10px">
                    <el-card shadow="hover" >
                        <div slot="header">
                            <span>故障分布</span>
                        </div>
                        <div class="item">
                            <div id="over2" style="width: 100%;height: 300px"></div>
                        </div>
                    </el-card>
                    <el-card style="margin-top: 10px;" shadow="hover" >
                        <div slot="header">
                            <span>故障日志</span>
                        </div>
                        <div class="item" style="position: relative;overflow: hidden;width: 100%;height: 290px">
                            <div style="overflow-y: auto;height: 100%; width:100%;overflow-x: hidden;">
                                <ul class="Glog">
                                    <li style="cursor: pointer;margin-bottom: 10px;" v-for="(item) in gLog">
                                        <i class="el-icon-bell" style="margin-left: 10px;color: #ff3003"></i>
                                        <span class="testinfo">节点:{{item.device}}</span>
                                        <span class="testinfo">故障级别:{{item.type}}</span>
                                        <span class="testtime">{{item.time}}</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </el-card>
                </div>
            </el-col>
        </el-row>
    </div>
</template>

<script>
    export default {
        name: "overall",
        data() {
            return {
                chart: '',
                option: '',
                deviceTotal: 130,
                gLog: [
                    {
                        device: '172.17.137.101',
                        type: '2',
                        time: '2020-02-09 06:22:45'
                    },{
                        device:'172.17.137.115',
                        type:'3',
                        time:'2020-02-09 16:22:45'
                    },{
                        device:'172.17.137.60',
                        type:'2',
                        time:'2020-02-12 07:22:45'
                    }
                ]
            }
        },
        methods: {
            getOverInfo() {
                this.getRequest().then(res => {
                    this.initChartover(res);
                })
            },
            //故障统计
            initChartover(obj) {
                this.chart = this.$echarts.init(document.getElementById("over"));
                this.option = {
                    tooltip: {
                        trigger: 'item',
                        formatter: '{a} <br/>{b} : {c}个 ({d}%)'
                    },
                    series: [
                        {
                            name: '设备情况',
                            type: 'pie',
                            radius: '55%',
                            center: ['50%', '40%'],
                            data: [
                                {value: 1, name: '故障'},
                                {value: 0, name: '危险'},
                                {value: 23, name: '正常'},
                                {value: 96, name: 'SnmpNotResponse'},
                            ],

                        }
                    ]
                };
                this.chart.setOption(this.option);
                window.addEventListener("resize", this.chart.resize);
            },
            //设备统计
            initChartover1(obj) {
                this.chart = this.$echarts.init(document.getElementById("over1"));
                this.option = {
                    tooltip: {
                        trigger: 'item',
                        formatter: '{a} <br/>{b} : {c}个 ({d}%)'
                    },
                    series: [
                        {
                            name: '设备情况',
                            type: 'pie',
                            radius: '55%',
                            center: ['50%', '40%'],
                            data: [
                                {value: 6, name: '路由器'},
                                {value: 12, name: '三层交换机'},
                                {value: 2, name: '二层交换机'},
                                {value: 2, name: '服务器'},
                                {value: 100, name: '未知设备'},
                            ],

                        }
                    ]
                };
                this.chart.setOption(this.option);
                window.addEventListener("resize", this.chart.resize);
            },
            //故障日志
            initChartover2(obj) {
                this.chart = this.$echarts.init(document.getElementById("over2"));
                this.option = {
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow'
                        },
                        formatter: '{a} <br/>{b} : {c}个 '
                    },
                    grid: {
                        left: '3%',
                        top: '3%',
                        containLabel: true
                    },
                    xAxis: {
                        type: 'value',
                        boundaryGap: [0, 0.01]
                    },
                    yAxis: {
                        type: 'category',
                        data: ['路由器', '三层交换机', '二层交换机', '服务器']
                    },
                    series: [
                        {
                            name: '故障数',
                            type: 'bar',
                            data: [0, 0, 1, 0]
                        }
                    ]
                };
                this.chart.setOption(this.option);
                window.addEventListener("resize", this.chart.resize);
            },
        },
        mounted() {
            this.initChartover();
            this.initChartover1();
            this.initChartover2();
        },
    }
</script>

<style scoped>
    body {
        font-family: 微软雅黑, Arial;
        font-size: 12px;
        padding: 0px;
        font-weight: 400;
    }

    .Glog {
        padding: 0;
        margin: 0;
        list-style: none;
        line-height: 0;
    }
    .Glog li{
        position: relative;
        height: 30px;
        line-height: 30px !important;
        border-bottom: 1px solid #3dd0f2;
    }
    .Glog img {
        float: left;
        width: 20px;
        height: 20px;
        vertical-align: middle;
        margin-right: 10px;
        margin-top: 3px;
    }

    .testinfo {
        max-width: 50%;
        overflow: hidden;
        white-space: nowrap;
        margin-left: 15px;
    }

    .testtime {
        position: absolute;
        right: 0;
        top: 0;
        max-width: 30%;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
        display: block;
    }

    a {
        text-decoration: none;
        font-size: 12px;
    }
</style>
