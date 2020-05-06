<template>
    <div :id="id" :style="style"></div>
</template>

<script>
    export default {
        name: "SingleDevFail",
        data(){
            return{

                chart:'',
                pieData:[]
            }
        },
        computed: {
            style() {
                return {
                    height: this.height,
                    width: this.width
                }
            }
        },
        props:{
            id: {
                type: String
            },
            ip:{
                type:String
            },
            width: {
                type: String,
                default: "100%"
            },
            height: {
                type: String,
                default: "340px"
            },
            data: String,
        },
        methods:{
            getDeviceData(ip){
                this.getRequest("/faultoverview/pie/?ip="+ip).then(res=>{
                    this.pieData = res;
                    this.initSingle();
                })
            },
            initSingle(){
                let legend=[];
                if (this.pieData.length === 0) {
                   legend=['PING连通性', 'cpu使用率', '内存使用率', 'SNMP连通性', 'OSPF','接口状态'];
                }else {
                    for (let i in this.pieData) {
                        legend[i]=this.pieData[i].name;
                    }
                }
                this.chart = this.$echarts.init(document.getElementById(this.id));
                let option ={
                    noDataLoadingOption:{
                        effect:"bubble",
                        text:"暂无数据",
                        effectOption:{
                            effect:{
                                n:0
                            }
                        },
                        textStyle:{
                            fontSize:32,
                            fontWeight:'bold'
                        }
                    },
                    title: {
                        subtext: '该设备出现某种故障的次数',
                            left: 'center'
                    },
                    tooltip: {
                        trigger: 'item',
                            formatter: '{a} <br/>{b} : {c} ({d}%)'
                    },
                    legend: {
                        orient: 'vertical',
                            left: 'left',
                            data: legend
                    },
                    series: [
                        {
                            name: '故障频率',
                            type: 'pie',
                            radius: '55%',
                            center: ['50%', '60%'],
                            data: this.pieData,
                            emphasis: {
                                itemStyle: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            },

                        }
                    ]
                };

                this.chart.setOption(option);
                window.addEventListener("resize", this.chart.resize);
            }
        },
        mounted() {
            this.initSingle();
        },
        watch:{
            data:{
                handler (newV, oldV) {
                    this.getDeviceData(newV)
                },
                deep:true
            },
        }
    }
</script>

<style>

</style>
