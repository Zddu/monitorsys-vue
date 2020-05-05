<template>
    <div>
        <div :id="id" :style="style"></div>
    </div>
</template>

<script>
    export default {
        name: "DiskInfo",
        data() {
            return {
                chart: '',
                option: '',
                diskName: [],
                diskCapacity: [],
                diskRate: [],
                diskTime:[],
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
        },
        computed: {
            style() {
                return {
                    height: this.height,
                    width: this.width
                }
            }
        },
        methods: {
            getDiskInfo() {
                this.getRequest("/monitor/disk/").then(res => {
                    this.initDisk(res);
                });
            },
            initDisk(obj) {
                let that = this;
                for (let i in obj) {
                    that.diskName.push(obj[i].diskName);
                    that.diskCapacity.push(obj[i].diskCapacity);
                    that.diskRate.push(obj[i].diskRate);
                    that.diskTime.push(obj[i].time);
                }
                this.chart = this.$echarts.init(document.getElementById(this.id));
                this.option = {
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross',
                            label: {
                                backgroundColor: '#283b56'
                            }
                        }
                    },
                    legend: {
                        data: ['磁盘使用率', '磁盘容量MB']
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
                            data: that.diskName
                        },
                        {
                            type: 'category',
                            boundaryGap: true,
                            data: that.diskName
                        },
                    ],
                    yAxis: [
                        {
                            type: 'value',
                            scale: true,
                            name: '磁盘使用率%',
                            max: 100,
                            min: 0,
                            boundaryGap: [0.2, 0.2]
                        },
                        {
                            type: 'value',
                            scale: true,
                            name: '磁盘容量MB',
                            min: 0,
                            boundaryGap: [0.2, 0.2]
                        }
                    ],
                    series: [
                        {
                            name: '磁盘容量MB',
                            type: 'bar',
                            xAxisIndex: 1,
                            yAxisIndex: 1,
                            data: that.diskCapacity
                        },
                        {
                            name: '磁盘使用率%',
                            type: 'line',
                            data: that.diskRate
                        }
                    ]
                };
                that.chart.setOption(this.option);
                window.addEventListener("resize", this.chart.resize);
            }
        },
        mounted() {
            this.getDiskInfo();
        },

    }
</script>

<style>

</style>
