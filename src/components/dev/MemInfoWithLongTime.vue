<template>
    <div :id="id" :style="style"></div>
</template>

<script>
    export default {
        name: "MemInfoWithLongTime",
        data() {
            return {
                chart: '',
                option: {
                    title: {
                        subtext: '一年内该设备内存使用率情况',
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
                        data: ['内存使用率'],
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
                            name: '内存使用率(%)',
                            type: 'value',
                        }
                    ],
                    series: [
                        {
                            name: '内存使用率',
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
                mem:[]
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
            this.init();
            this.getMem()
        },
        methods: {
            getMem(ip) {
                this.getRequest("/device/getmemory?ip=" + ip).then(res => {
                   this.init(res);
                })
            },
            init(res) {
                this.chart = this.$echarts.init(document.getElementById(this.id));
                this.option.xAxis[0].data = [];
                this.option.series[0].data = [];
                for (let i in res) {
                    this.option.xAxis[0].data.push(res[i].time);
                    this.option.series[0].data.push(res[i].memRate)
                }
                this.chart.setOption(this.option,true);
                window.addEventListener("resize", this.chart.resize);
            }
        },
        watch: {
            data: {
                handler(newV, oldV) {
                    this.getMem(newV)
                },
                deep: true
            }
        }
    }
</script>

<style>

</style>
