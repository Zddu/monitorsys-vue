<template>
    <div :id="id" :style="style"></div>
</template>

<script>
    export default {
        name: "SingleTimeFail",
        data(){
            return{
                option :{
                    title:{
                        subtext:'不同时间段故障发生次数',
                        top: '20'
                    },
                    legend: {},
                    tooltip: {},
                    xAxis: [
                        {
                            type: 'category',
                            gridIndex: 0,
                            data:['8:00-12:00', '12:00-16:00', '16:00:20:00', '20:00-24:00','24:00-4:00','4:00-8:00']
                        },
                    ],
                    yAxis: [
                        {gridIndex: 0},
                    ],
                    grid: [
                        {bottom: '10%'},
                        {top: '5%'}
                    ],
                    series: [
                        {
                            name: 'SNMP连通性',
                            type: 'bar',
                            label:'SNMP连通性',
                            data: [320, 332, 301, 334, 390, 390]
                        },
                        {
                            name: 'CPU利用率',
                            type: 'bar',
                            label: 'CPU利用率',
                            data: [220, 182, 191, 234, 290, 290]
                        },
                        {
                            name: 'Ping连通性',
                            type: 'bar',
                            label: 'Ping连通性',
                            data: [150, 232, 201, 154, 190, 190]
                        },
                        {
                            name: '内存使用率',
                            type: 'bar',
                            label: '内存使用率',
                            data: [98, 77, 101, 99, 40, 40]
                        },
                        {
                            name: 'OSPF',
                            type: 'bar',
                            label: 'OSPF',
                            data: [98, 77, 101, 99, 40, 40]
                        },
                        {
                            name: '端口状态',
                            type: 'bar',
                            label: '端口状态',
                            data: [98, 77, 101, 99, 40, 40]
                        }
                    ]
                },
                chart:'',
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
            initSinleData(ip){
              this.getRequest("/faultoverview/two/?ip="+ip).then(res=>{
                  console.log(res);
              })
            },
            initSingleTime(){
                this.chart = this.$echarts.init(document.getElementById(this.id));
                this.chart.setOption(this.option,true);
                window.addEventListener("resize", this.chart.resize);
            }
        },
        mounted() {
            this.initSinleData();
            this.initSingleTime();
        },
        watch:{
            data:{
                handler (newV, oldV) {
                    this.initSinleData(newV)
                },
                deep:true
            },
        }
    }
</script>

<style scoped>

</style>
