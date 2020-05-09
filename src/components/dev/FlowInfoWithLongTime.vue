<template>
    <div :id="id"  :style="style"></div>
</template>

<script>
    export default {
        name: "FlowInfoWithLongTime",
        data(){
            return{
                chart: '',
                option:{
                    title: {
                        subtext: '一年内该设备流量情况',
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
                        data: ['接收流量','发送流量'],
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
                            name: '流量(Kbits/s)',
                            type: 'value',
                        }
                    ],
                    series: [
                        {
                            name: '接收流量',
                            type: 'line',
                            animation: false,
                            lineStyle: {
                                width: 1
                            },
                            data: [],
                            smooth:true
                        },{
                            name: '发送流量',
                            type: 'line',
                            animation: false,
                            lineStyle: {
                                width: 1
                            },
                            data: [],
                            smooth:true
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
                    this.option.series[0].data.push(d[i].inFlow);
                    this.option.series[1].data.push(d[i].outFlow)
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
