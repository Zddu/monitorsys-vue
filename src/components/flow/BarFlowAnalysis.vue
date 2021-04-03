<template>
    <div :id="id" :style="style"></div>
</template>

<script>
    export default {
        name: "BarFlowAnalysis",
        data(){
            return{
                chart:'',
                option:{
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross',
                            crossStyle: {
                                color: '#999'
                            }
                        }
                    },
                    toolbox: {
                        feature: {
                            dataView: {show: true, readOnly: false},
                            magicType: {show: true, type: ['line', 'bar']},
                            restore: {show: true},
                            saveAsImage: {show: true}
                        }
                    },
                    legend: {
                        data: [ 'count']
                    },
                    xAxis: [
                        {
                            type: 'category',
                            data: ['DATABASE', 'HTTP', 'HTTPs', 'MAIL', 'MULTIMEDIA', 'P2P', 'WWW', 'FTPRETR', 'ssh', 'ATTACK'],
                            axisPointer: {
                                type: 'shadow'
                            }
                        }
                    ],
                    yAxis: [
                        {
                            type: 'value',
                            name: 'count',
                            min: 0,
                            axisLabel: {
                                formatter: '{value} '
                            }
                        }
                    ],
                    series: [
                        {
                            name: 'count',
                            type: 'bar',
                            data: [2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 6.0, 2.3]
                        },
                    ]
                },
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
        mounted(){
          this.init();
        },
        methods:{
            init(obj) {
                this.chart = this.$echarts.init(document.getElementById(this.id));
                this.option.xAxis[0].data = [];
                this.option.series[0].data = [];
                for (let i in obj) {
                    this.option.xAxis[0].data.push(obj[i].name);
                    this.option.series[0].data.push(obj[i]);
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

