<template>
    <div :id="id"  :style="style"></div>
</template>

<script>
    export default {
        name: "alarmInfo",
        data(){
            return{
                chart: '',
                option:{
                    title: {
                        subtext: '故障分布',
                        left:'center',
                        subtextStyle:{
                            color:'#dd7b33'
                        }
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow'
                        }
                    },
                    legend: {
                        left: 'left',
                        data: ['故障发生次数']
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: {
                        type: 'value',
                        boundaryGap: [0, 0.01]
                    },
                    yAxis: {
                        type: 'category',
                        data: ['三层交换机', '二层交换机', '服务器', '路由器']
                    },
                    series: [
                        {
                            name: '故障发生次数',
                            type: 'bar',
                            data: [18, 23, 29, 10]
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
                default: "220px"
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
             this.getRequest("/home/getFaultDistribution").then(res=>{
                 this.init(res);
             })
            },
            init(obj){
                this.chart = this.$echarts.init(document.getElementById(this.id));
                this.option.series[0].data=[];
                this.option.series[0].data[0]=obj[0].num
                this.option.series[0].data[1]=obj[1].num
                this.option.series[0].data[2]=obj[2].num
                this.option.series[0].data[3]=obj[3].num
                this.chart.setOption(this.option, true);
                window.addEventListener("resize", this.chart.resize);
            }
        }
    }
</script>

<style scoped>

</style>
