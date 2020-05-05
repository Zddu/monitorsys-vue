<template>
    <div :id="id" :style="style"></div>
</template>

<script>
    export default {
        name: "DevAll",
        data(){
            return{
                allDev:{
                    yAxis:[],
                    series:[],
                    time:'',
                },
                option :{
                    title: {
                        text: 'TOP10',
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow'
                        }
                    },
                    legend: {
                        data: ['TOP10节点故障次数']
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
                        data: ['172.17.137.115', '172.17.136.125', '172.17.137.125', '10.1.1.2', '10.1.13', '172.17.136.125','172.17.136.125','172.17.136.125','172.17.136.125','172.17.136.125']
                    },
                    series: [
                        {
                            name: 'TOP10节点故障次数',
                            type: 'bar',
                            data: [10,20,11,23,25,44,16,18,61,23]
                        }
                    ]
                },
                chart:'',
            }
        },
        props:{
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
            devallData: Array,
        },
        computed: {
            style() {
                return {
                    height: this.height,
                    width: this.width,

                }
            }
        },
        methods:{
          initDev(){
              this.chart = this.$echarts.init(document.getElementById(this.id));
              this.option.yAxis.data=[];
              this.option.series[0].data=[];
              for (let i=this.devallData.length-1; i>=0;i--) {
                  this.option.yAxis.data.push(this.devallData[i].ip);
                  this.option.series[0].data.push(this.devallData[i].num);
              }
              this.chart.setOption(this.option,true);
              window.addEventListener("resize", this.chart.resize);
          },
        },
        mounted() {
            this.initDev();
        },
        watch:{
            devallData:{
                handler (newV, oldV) {
                    this.initDev();
                },
                deep:true
            },
        }
    }
</script>

<style>

</style>
