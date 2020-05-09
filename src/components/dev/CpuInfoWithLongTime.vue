<template>
    <div :id="id"   :style="style"></div>
</template>

<script>
    export default {
        name: "CpuInfoWithLongTime",
        data(){
            return{
                chart: '',
                option:{
                    title: {
                        subtext: '一年内该设备CPU使用率情况',
                        left: 'center',
                        align: 'right'
                    },
                    grid: {
                        bottom: 80
                    },
                    toolbox: {
                        feature: {
                            dataZoom: {
                                yAxisIndex: 'none'
                            },
                            restore: {},
                            saveAsImage: {}
                        }
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross',
                            animation: false,
                            label: {
                                backgroundColor: '#505765'
                            }
                        }
                    },
                    legend: {
                        data: ['CPU使用率'],
                        left: 10
                    },
                    dataZoom: [
                        {
                            show: true,
                            realtime: true,
                            start: 65,
                            end: 85
                        },
                        {
                            type: 'inside',
                            realtime: true,
                            start: 65,
                            end: 85
                        }
                    ],
                    xAxis: [
                        {
                            type: 'category',
                            boundaryGap: false,
                            axisLine: {onZero: false},
                            data: []

                        }
                    ],
                    yAxis: [
                        {
                            name: 'CPU使用率(%)',
                            type: 'value',
                        }
                    ],
                    series: [
                        {
                            name: 'CPU使用率',
                            type: 'line',
                            animation: false,
                            areaStyle: {},
                            lineStyle: {
                                width: 1
                            },
                            data: [],
                            smooth: true,
                        }
                    ]
                },
                cpu:[]
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
            data: String,
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
            this.getData();
            this.init();
        },
        methods:{
            getData(ip){
                this.getRequest("/device/getcup?ip="+ip).then(res=>{
                    this.init(res);
                })
            },
            init(res) {
                this.chart = this.$echarts.init(document.getElementById(this.id));
                this.option.xAxis[0].data=[];
                this.option.series[0].data=[];
                for (let i in res) {
                    this.option.xAxis[0].data.push(res[i].time);
                    this.option.series[0].data.push(res[i].cpuRate)
                }
                this.chart.setOption(this.option,true);
                window.addEventListener("resize", this.chart.resize);
            }
        },
        watch:{
            data:{
                handler (newV, oldV) {
                    this.getData(newV);
                },
                deep:true
            },
        }
    }
</script>

<style scoped>

</style>
