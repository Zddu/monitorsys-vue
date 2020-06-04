<template>
    <div :id="id" :style="style"></div>
</template>

<script>
    export default {
        name: "PieFlowAnalysis",
        data() {
            return {
                chart: '',
                option: {
                    title: {
                        subtext: '流量分类',
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'item',
                        formatter: '{a} <br/>{b} : {c} ({d}%)'
                    },
                    legend: {
                        orient: 'vertical',
                        left: 'left',
                        data: ['直接访问', '邮件营销', '联盟广告', '视频广告', '搜索引擎']
                    },
                    series: [
                        {
                            selectedMode: 'single',
                            name: '访问来源',
                            type: 'pie',
                            radius: '55%',
                            center: ['50%', '60%'],
                            data: [
                                {value: 335, name: '直接访问'},
                                {value: 310, name: '邮件营销'},
                                {value: 234, name: '联盟广告'},
                                {value: 135, name: '视频广告'},
                                {value: 1548, name: '搜索引擎'}
                            ],
                            label: {
                                formatter: '{a|{a}}{abg|}\n{hr|}\n  {b|{b}：}{c}  {per|{d}%}  ',
                                backgroundColor: '#eee',
                                borderColor: '#aaa',
                                borderWidth: 1,
                                borderRadius: 4,
                                // shadowBlur:3,
                                // shadowOffsetX: 2,
                                // shadowOffsetY: 2,
                                // shadowColor: '#999',
                                // padding: [0, 7],
                                rich: {
                                    a: {
                                        color: '#999',
                                        lineHeight: 22,
                                        align: 'center'
                                    },
                                    // abg: {
                                    //     backgroundColor: '#333',
                                    //     width: '100%',
                                    //     align: 'right',
                                    //     height: 22,
                                    //     borderRadius: [4, 4, 0, 0]
                                    // },
                                    hr: {
                                        borderColor: '#aaa',
                                        width: '100%',
                                        borderWidth: 0.5,
                                        height: 0
                                    },
                                    b: {
                                        fontSize: 16,
                                        lineHeight: 33
                                    },
                                    per: {
                                        color: '#eee',
                                        backgroundColor: '#334455',
                                        padding: [2, 4],
                                        borderRadius: 2
                                    }
                                }
                            },

                            emphasis: {
                                itemStyle: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
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
                default: "100%"
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
        mounted(){
          this.init();
        },
        methods:{
            init(obj) {
                this.chart = this.$echarts.init(document.getElementById(this.id));
                // this.option.xAxis[0].data = [];
                // this.option.series[0].data = [];
                // for (let i = obj.length - 1; i >= 0; i--) {
                //     this.option.xAxis[0].data.push(obj[i].time);
                //     this.option.series[0].data.push(obj[i].cpuRate);
                // }
                this.chart.setOption(this.option, true);
                window.addEventListener("resize", this.chart.resize);
            }
        },
        watch: {
            ip: {
                handler(newV, oldV) {
                },
                deep: true
            },
        }
    }
</script>

<style scoped>

</style>
