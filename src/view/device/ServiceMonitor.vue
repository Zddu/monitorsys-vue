<template>
    <div>
        <el-row >
            <el-col :span="8">
                <el-row>
                    <el-col>
                        <BaseInfo/>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col>
                        <MemoryInfo/>
                    </el-col>
                </el-row>
            </el-col>
            <el-col :span="15" style="margin-left: 10px">
                <el-row>
                    <el-col>
                        <el-card class="box-card">
                            <div slot="header" class="clearfix">
                                <span>CPU使用情况</span>
                            </div>
                            <CpuInfo id="test"  :data="chartData"/>
                        </el-card>
                    </el-col>
                </el-row>
                <el-row style="margin-top: 10px;">
                    <el-col>
                        <el-card class="box-card">
                            <div slot="header" class="clearfix">
                                <span>磁盘使用情况</span>
                            </div>
                           <DiskInfo id="disk" :data="diskData"/>
                        </el-card>
                    </el-col>
                </el-row>
            </el-col>
        </el-row>

    </div>
</template>

<script>
    import BaseInfo from "../../components/dev/BaseInfo";
    import CpuInfo from "../../components/dev/CpuInfo";
    import DiskInfo from "../../components/dev/DiskInfo";
    import MemoryInfo from "../../components/dev/MemoryInfo";

    export default {
        name: "ServiceMonitor",
        components:{
            MemoryInfo,
            BaseInfo,
            CpuInfo,
            DiskInfo
        },
        data() {
            return {
                chartData:{
                    cpuRate:[],
                    xDate:[]
                },
                diskData:[],
            }
        },
        methods: {
            //添加refreshData方法进行自动设置数据
            initData(){
                setInterval(()=>{
                    this.getRequest("/monitor/cpu/").then(res=>{
                        this.chartData.cpuRate = res.cpuRate;
                        let axisData = (new Date()).toLocaleTimeString('chinese', { hour12: false }).replace(/^\D*/, '');
                        this.chartData.xDate=axisData;
                    })
                },5*60*1000);
            },
        },
        mounted() {
            this.initData();
        }
    }
</script>
<style>
</style>
