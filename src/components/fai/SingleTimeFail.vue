<template>
    <div :id="id" :style="style"></div>
</template>

<script>
    export default {
        name: "SingleTimeFail",
        data(){
            return{
                chart:'',
                seriesDatas:[],
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
                console.log(ip);
                this.getRequest("/faultoverview/timeSlot/?ip="+ip).then(res=>{
                  console.log(res);
                  this.initChart(res);
              })
            },
            initChart(res){
                this.chart = this.$echarts.init(document.getElementById(this.id));
                let option ={
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
                    series: res
                };
                this.chart.setOption(option,true);
                window.addEventListener("resize", this.chart.resize);
            }
        },
        mounted() {
            this.initChart();
        },
        watch:{
            data:{
                handler (newV, oldV) {
                    console.log(newV);
                    this.initSinleData(newV)
                },
                deep:true
            },
        }
    }
</script>

<style scoped>

</style>
