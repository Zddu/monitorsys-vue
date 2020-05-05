<template>
    <div :id="id" :style="style"></div>
</template>

<script>
    export default {
        name: "PointAll",
        data(){
            return{
                option :{
                    title: {
                        text: '监测点出现次数',
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow'
                        }
                    },
                    legend: {
                        data: ['设备数量']
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
                        data: []
                    },
                    series: [
                        {
                            name: '设备数量',
                            type: 'bar',
                            data: [],
                            color: ['#f49f42'],
                        },
                    ]
                },
                chart:'',
            }
        },
        computed: {
            style() {
                return {
                    height: this.height,
                    width: this.width
                }
            }
        },
        props:{
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
                default: "260px"
            },
            pointData: Array,
        },
        methods:{
            initPoint(){
                this.option.yAxis.data=[];
                this.option.series[0].data=[];
                this.chart = this.$echarts.init(document.getElementById(this.id));
                for (let i in this.pointData) {
                    this.option.yAxis.data.push(this.pointData[i].point);
                    this.option.series[0].data.push(this.pointData[i].num);
                }
                this.chart.setOption(this.option,true);
                window.addEventListener("resize", this.chart.resize);
            }
        },
        mounted() {
            this.initPoint();
        },
        watch:{
            pointData:{
                handler (newV, oldV) {
                    this.option.yAxis.data=[];
                    this.option.series[0].data=[];
                    this.initPoint();
                },
                deep:true
            },
        }
    }
</script>

<style>

</style>
