<template>
    <div :id="id" :style="style"></div>
</template>

<script>
    export default {
        name: "LineFlowAnalysis",
        data() {
            return {
                option:{
                    title: {
                        subtext: '流量分类预测概率',
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
                        data: ['prediction'],
                        left: 10
                    },
                    dataZoom: [
                        {
                            show: true,
                            realtime: true,
                            start: 0,
                            end: 5
                        },
                        {
                            type: 'inside',
                            realtime: true,
                            start: 0,
                            end: 5
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
                            name: 'prediction',
                            type: 'value',
                            min:0,
                            max:1,
                        }
                    ],
                    series: [
                        {
                            name: 'prediction',
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
                chart:''
            }
        },
        props: {
            id: {
                type: String
            },
            ip: {
                type: String
            },
            width: {
                type: String,
                default: "100%"
            },
            height: {
                type: String,
                default: "100%"
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
        methods: {
            init(obj) {
                console.log(obj);
                this.chart = this.$echarts.init(document.getElementById(this.id));
                this.option.xAxis[0].data = [];
                this.option.series[0].data = [];
                for (let i in obj) {
                    this.option.xAxis[0].data.push(obj[i].name);
                    this.option.series[0].data.push(obj[i].prediction);
                }
                this.chart.setOption(this.option, true);
                window.addEventListener("resize", this.chart.resize);
            }
        },
        watch: {
            data: {
                handler(newV, oldV) {
                    this.init(newV);
                },
                deep: true
            },
        }
    }
</script>

