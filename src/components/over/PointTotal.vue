<template>
    <div :id="id"  :style="style"></div>
</template>

<script>
    export default {
        name: "PointTotal",
        data(){
            return{
                chart: '',
                option:{
                    title: {
                        subtext: '监测点统计',
                        left:'48%',
                        top:'10%',
                        subtextStyle:{
                            color:'#dd7b33'
                        }
                    },
                    tooltip: {
                        trigger: 'item',
                        formatter: '{a} <br/>{b} : {c} ({d}%)'
                    },
                    legend: {
                        orient: 'vertical',
                        left: 'left',
                        data: []
                    },
                    series: [
                        {
                            name: '监测点故障次数',
                            type: 'pie',
                            radius: '55%',
                            center: ['55%', '70%'],
                            data: [ ],
                            emphasis: {
                                itemStyle: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
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
                default: "300px"
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
              this.getRequest("/home/getPointsStatistics").then(res=>{
                  this.init(res);
              })
            },
            init(obj){
                console.log(obj);
                this.chart = this.$echarts.init(document.getElementById(this.id));
                this.option.legend.data=[];
                this.option.series[0].data=obj;
                for (let i in obj) {
                    this.option.legend.data.push(obj[i].name);
                }
                this.chart.setOption(this.option, true);
                window.addEventListener("resize", this.chart.resize);
            }
        }
    }
</script>

<style scoped>

</style>
