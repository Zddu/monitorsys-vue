<template>
    <div :id="id"  :style="style"></div>
</template>

<script>
    export default {
        name: "ShowLocalMem",
        data(){
            return{
                chart: '',
                option:{
                    title: {
                        subtext: '本机内存使用率',
                        left:'left',
                        subtextStyle:{
                            color:'#dd7b33'
                        }
                    },
                    tooltip: {
                        trigger: 'axis',
                        formatter: ' {b}<br/>{a} : {c} %'
                    },
                    legend: {
                        data: ['本机内存使用率']
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    toolbox: {
                        feature: {
                            saveAsImage: {}
                        }
                    },
                    xAxis: {
                        type: 'category',
                        boundaryGap: true,
                        data: []
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [
                        {
                            name: '本机内存使用率',
                            type: 'line',
                            stack: '总量',
                            data: []
                        }
                    ]
                },

            }
        },
        props: {
            id: {
                type: String
            },
            width: {
                type: String,
                default: "100%"
            },
            height: {
                type: String,
                default: "260px"
            },
            data: Array,
        },
        computed: {
            style() {
                return {
                    height: this.height,
                    width: this.width
                }
            }
        },
        mounted() {
            this.getInfo();
        },
        methods:{
            getInfo(){
              this.getRequest("/home/getMemory").then(res=>{
                  this.init(res);
              })
            },
            init(obj){
                this.chart = this.$echarts.init(document.getElementById(this.id));
                this.option.xAxis.data=[];
                this.option.series[0].data=[];
                for (let i=obj.length-1;i>=0;i--) {
                    this.option.xAxis.data.push(obj[i].time);
                    this.option.series[0].data.push(obj[i].memRate);
                }
                this.chart.setOption(this.option, true);
                window.addEventListener("resize", this.chart.resize);
            }
        }
    }
</script>

<style scoped>

</style>
