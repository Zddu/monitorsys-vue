
<template>
    <div :id="id"  :style="style"></div>
</template>

<script>
    export default {
        name: "FlowDataAnalysisByError",
        data(){
            return{
                chart: '',
                option:{
                    title: {
                        subtext: '一年流过该设备的综合数据展示',
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
                        data: ['数据接收错误率','数据发送错误率'],
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
                            start: 25,
                            end: 75
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
                            name: '占比率(%)',
                            type: 'value',
                        },
                    ],
                    series: [
                        {
                            name: '数据接收错误率',
                            type: 'line',
                            animation: false,
                            lineStyle: {
                                width: 1
                            },
                            data: [],
                            smooth:true
                        },{
                            name: '数据发送错误率',
                            type: 'line',
                            animation: false,
                            lineStyle: {
                                width: 1
                            },
                            data: [],
                            smooth:true
                        },
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
            this.init();
        },
        methods:{
            init(d) {
                this.chart = this.$echarts.init(document.getElementById(this.id));
                this.option.xAxis[0].data = [];
                this.option.series[0].data = [];
                this.option.series[1].data = [];
                for (let i in d) {
                    this.option.xAxis[0].data.push(d[i].time);
                    this.option.series[0].data.push(d[i].inErrorRate);
                    this.option.series[1].data.push(d[i].outErrorRate)
                }
                this.chart.setOption(this.option,true);
                window.addEventListener("resize", this.chart.resize);
            }
        },
        watch:{
            data:{
                handler(newV,oldV){
                    this.init(newV);
                },
                deep:true
            }
        }
    }
</script>

<style >

</style>
