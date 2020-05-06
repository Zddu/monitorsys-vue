<template>
    <div>
        <div style="height: 50px;width: 100%;padding: 0px 17px;line-height: 50px;box-sizing: border-box">
            <span>选择日期范围查看：</span>
            <el-date-picker
                    size="small"
                    v-model="dateValue"
                    type="daterange"
                    align="right"
                    value-format="yyyy-MM-dd"
                    unlink-panels
                    range-separator="至"
                    start-placeholder="开始日期"
                    end-placeholder="结束日期"
                    @change="selectTime"
                    :picker-options="pickerOptions">
            </el-date-picker>
        </div>
        <div style="display: flex;align-content: space-around;margin: 0 10px">
            <PointAll id="point" :pointData="pointData" style="margin-right: 10px" />
            <DevAll id="devall" :devallData="devallData" />
        </div>
        <el-divider><i class="el-icon-s-data"></i></el-divider>
        <div style="width: 100%">
            <span style="margin-right: 10px;">搜索特定IP节点显示该设备的故障图表：</span>
            <el-select @change="selectedDev" style="width: 340px;margin-right: 10px;" size="small" filterable  default-first-option v-model="value" placeholder="请选择搜索设备">
                <el-option-group
                        v-for="group in options"
                        :key="group.label"
                        :label="group.label">
                    <el-option
                            v-for="item in group.options"
                            :key="item.ip"
                            :label="item.ip"
                            :value="item.ip">
                        <span style="float: right">{{ item.name }}</span>
                        <span style="float: left; color: #8492a6; font-size: 13px">{{ item.ip }}</span>
                    </el-option>
                </el-option-group>
            </el-select>
            <div style="display: flex;align-content: flex-start">
                <SingleDevFail id="Single" :data="SingleData" />
                <SingleTimeFail id="SingleTime" :data="SingleTimeData" />
            </div>
        </div>

    </div>
</template>

<script>
    import PointAll from "../../components/fai/PointAll";
    import DevAll from "../../components/fai/DevAll";
    import SingleDevFail from "../../components/fai/SingleDevFail";
    import SingleTimeFail from "../../components/fai/SingleTimeFail";
    export default {
        name: "FailureAll",
        components: {SingleDevFail, DevAll, PointAll,SingleTimeFail},
        data(){
            return {
                pointData:[],
                devallData:[],
                SingleData:'',
                SingleTimeData:'',
                dateValue:'',
                pickerOptions: {
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
                options: [{
                    label: '服务器',
                    options: []
                }, {
                    label: '网络设备',
                    options: []
                }, {
                    label: 'SNMP服务配置有误',
                    options: []
                }],
                value: ''
            }
        },
        methods:{
            selectDevice(){
                this.getRequest("/faultoverview/select/").then(res=>{
                    this.value = res[79].ip.toString();
                    this.SingleData= this.value;
                    this.SingleTimeData= this.value;
                    for(let i =0;i<res.length;i++){
                        if (res[i].typename === '服务器') {
                            this.options[0].options.push(res[i])
                        }else if(res[i].typename === 'SNMP服务配置有误'){
                            this.options[2].options.push(res[i])
                        }else{
                            this.options[1].options.push(res[i])
                        }
                    }
                })
            },
            selectedDev(){
                this.SingleTimeData=this.value;
                this.SingleData=this.value;
            },
            selectTime(){
                if(this.dateValue===null){
                    this.dateValue='';
                }
                this.getRequest("/faultoverview/one/?time="+this.dateValue.toString()).then(res=>{
                    this.pointData=res.faultNums;
                    this.devallData=res.top10IpFaults;
                })
            },
            initChartOne(){
                this.getRequest("/faultoverview/one").then(res=>{
                    this.pointData=res.faultNums;
                    this.devallData=res.top10IpFaults;
                })
            }
        },
        mounted() {
            this.selectDevice();
            this.initChartOne();
        }
    }
</script>

<style>

</style>
