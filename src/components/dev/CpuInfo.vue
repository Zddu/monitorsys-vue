<template>
    <div :id="id" :style="style"></div>
</template>

<script>
    export default {
        name: "CpuInfo",
        data() {
            return {
                chart: '',
                cpuData: {
                    cpuRate: [],
                    time: [],
                },
                option: {
                    title: {
                        subtext: '若数值<0则设备SNMP服务未启用',
                        subtextStyle : {
                            // fontSize :'18',
                        }
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross',
                            label: {
                                backgroundColor: '#283b56'
                            }
                        },
                        textStyle:{
                            // fontSize:18
                        },
                        formatter: ' {b}<br/>{a} : {c} %'
                    },
                    legend: {
                        data: ['CPU使用率'],
                        textStyle:{
                            // fontSize:18
                        }
                    },
                    toolbox: {
                        show: true,
                        feature: {
                            dataView: {readOnly: false},
                            saveAsImage: {}
                        }
                    },
                    dataZoom: {
                        show: false,
                        start: 0,
                        end: 100
                    },
                    xAxis: [
                        {
                            type: 'category',
                            boundaryGap: true,
                            data: [],
                            axisLabel: {
                                textStyle: {
                                    // fontSize: 18,
                                }
                            },
                        },
                    ],
                    yAxis: [
                        {
                            type: 'value',
                            scale: true,
                            name: '使用率%',
                            nameTextStyle:{
                                // fontSize: 16,
                            },
                            min: 0,
                            boundaryGap: [0.2, 0.2],
                            axisLabel:{
                                textStyle: {
                                    // fontSize: 16,
                                }
                            }
                        }
                    ],
                    series: [
                        {
                            name: 'CPU使用率',
                            type: 'line',
                            data: [],
                            smooth: true,
                            areaStyle: {},
                            label: {
                                normal: {
                                    show: true,
                                    textStyle: {
                                        // fontSize: 18
                                    }
                                },
                            },
                        }
                    ]
                }
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
                default: "200px"
            },
            data: Object,
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
            this.initDataInfo();
        },
        methods: {
            initDataInfo() {
                this.getRequest("/monitor/cpu/" + this.ip).then(res => {
                    this.cpuData = res;
                    this.init(this.cpuData);
                });
            },
            init(obj) {
                console.log(obj);
                this.chart = this.$echarts.init(document.getElementById(this.id));
                this.option.xAxis[0].data = [];
                this.option.series[0].data = [];
                for (let i = obj.length - 1; i >= 0; i--) {
                    this.option.xAxis[0].data.push(obj[i].time);
                    this.option.series[0].data.push(obj[i].cpuRate);
                }
                this.chart.setOption(this.option, true);
                window.addEventListener("resize", this.chart.resize);
            }
        },
        watch: {
            ip: {
                handler(newV, oldV) {
                    this.initDataInfo()
                },
                deep: true
            },
        }
    }
</script>

<style>

</style>
