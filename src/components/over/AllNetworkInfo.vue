<template>
    <div :id="id" :style="style"></div>
</template>

<script>
    export default {
        name: "AllNetworkInfo",
        data() {
            return {
                chart: '',
                option: {
                    title: {
                        subtext: '全网信息统计',
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
                    grid: {
                        top: 40,
                    },
                    xAxis: {
                        type: 'category',
                        data: [ '设备总数', '监测点数', '故障总数']
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [
                        {
                            data: [],
                            type: 'bar',
                            showBackground: true,
                            backgroundStyle: {
                                color: 'rgba(220, 220, 220, 0.8)'
                            },
                            color:'#61a0a8'
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
        methods: {
            getInfo(){
              this.getRequest("/home/getInformationStatistics").then(res=>{
                  this.init(res);
              })
            },
            init(obj) {
                console.log(obj);
                this.chart = this.$echarts.init(document.getElementById(this.id));
                this.option.series[0].data=[];
                this.option.series[0].data[0]=obj.equipmentNums;
                this.option.series[0].data[2]=obj.faultNums;
                this.option.series[0].data[1]=obj.pointsNums;
                this.chart.setOption(this.option, true);
                window.addEventListener("resize", this.chart.resize);
            }
        }
    }
</script>

<style scoped>

</style>
