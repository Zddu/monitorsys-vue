<template>
    <div :id="id" :style="style"></div>
</template>

<script>
    export default {
        name: "MemoryInfo",
        data() {
            return {
                chart: '',
                memData:{
                    memRate:[],
                    time:[],
                },
                option:{
                    title:{
                        subtext:'若数值<0则设备SNMP服务未启用',
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
                        data: ['内存使用率'],
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
                                    // fontSize: 18,
                                }
                            }
                        }
                    ],
                    series: [
                        {
                            name: '内存使用率',
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
            ip:{
                type:String
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
            this.initDataMem();
        },
        methods: {
            initDataMem(){
                this.getRequest("/memory/five/"+this.ip).then(res=>{
                    this.memData = res;
                    this.initMem(this.memData);
                });
            },
            initMem(obj) {
                this.chart = this.$echarts.init(document.getElementById(this.id));
                this.option.xAxis[0].data=[];
                this.option.series[0].data=[];
                for (let i = obj.length-1; i>=0;i--) {
                    this.option.xAxis[0].data.push(obj[i].time);
                    this.option.series[0].data.push(obj[i].memRate);
                }
                this.chart.setOption(this.option,true);
                window.addEventListener("resize", this.chart.resize);
            }
        },
        watch:{
            ip:{
                handler (newV, oldV) {
                    this.initDataMem()
                },
                deep:true
            },
        }
    }
</script>

<style>

</style>
