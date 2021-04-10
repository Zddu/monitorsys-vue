<template>
    <div id="topo" style="width: 100%;height:600px"></div>
</template>

<script>
    import {isEmpty} from "../../utils/api";

    export default {
        name: "Topo",
        data() {
            return {
                chart: '',
                nodes: [],
                links: [],
                msg:'',
                option: {
                    tooltip: {//弹窗
                        trigger: 'item',
                        formatter: function (params) {
                            //根据值是否为空判断是点还是线段
                            if (!isEmpty(params.data.source)) {//如果鼠标移动到线条
                                return params.data.target + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;----&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
                                    params.data.source + "<br>" +
                                    params.data.dif + "&nbsp;&nbsp;&nbsp;&nbsp;" + params.data.sif+"<br>"+
                                    "链路利用率"+"："+params.data.dfRate+"%"+"&nbsp;&nbsp;&nbsp;&nbsp;"+params.data.sfRate+"%" +"<br>"+
                                    "链路流量"+": "+params.data.flow
                            } else {//如果鼠标移动到点
                                return  "IP"+"："+params.data.name+"<br>"+
                                    "别名" + "：" + params.data.selfName + "<br>" +
                                    "描述" + "：" + params.data.selfDecs + "<br>" +
                                    "名称" + "：" + params.data.sysName + " <br>" +
                                    "类型" + "：" + params.data.typeName + "<br>" +
                                    "CPU使用率" + "：" +params.data.cpuRate+"%" + "<br>"+
                                    "内存使用率" + "："  +params.data.memRate+"%";
                            }
                        }
                    },
                    color: ['#19d00f', '#fff31a', '#b5d0c9', '#5fd0cc'],
                    legend: { //=========小图标，圖表控件
                        data: [
                            {
                                name: '路由器',
                            },
                            {
                                name: '服务器',
                            }, {
                                name: '二层交换机',
                            }, {
                                name: '三层交换机',
                            }
                        ]
                    },
                    series: [
                        {//图片配置
                            type: 'graph', //关系图
                            layout: 'force', //图的布局，类型为力导图，'circular' 采用环形布局，见示例 Les Miserables
                            legendHoverLink: true,//是否启用图例 hover(悬停) 时的联动高亮。
                            hoverAnimation: true,//是否开启鼠标悬停节点的显示动画
                            force: {
                                repulsion: 500,//相距距离
                                edgeLength: [120, 200],
                                layoutAnimation: true
                            },

                            roam: true,//是否开启鼠标缩放和平移漫游。默认不开启。如果只想要开启缩放或者平移，可以设置成 'scale' 或者 'move'。设置成 true 为都开启
                            nodeScaleRatio: 0.6,//鼠标漫游缩放时节点的相应缩放比例，当设为0时节点不随着鼠标的缩放而缩放
                            draggable: true,//节点是否可拖拽，只在使用力引导布局的时候有用。
                            focusNodeAdjacency: false,//是否在鼠标移到节点上的时候突出显示节点以及节点的边和邻接节点。
                            edgeSymbol: ['none'],//边两端的标记类型，可以是一个数组分别指定两端，也可以是单个统一指定。默认不显示标记，常见的可以设置为箭头，如下：edgeSymbol: ['circle', 'arrow']
                            symbolSize: 50,//图形大小
                            edgeSymbolSize: 10,//边两端的标记大小，可以是一个数组分别指定两端，也可以是单个统一指定。
                            itemStyle: {//===============图形样式，有 normal 和 emphasis 两个状态。normal 是图形在默认状态下的样式；emphasis 是图形在高亮状态下的样式，比如在鼠标悬浮或者图例联动高亮时。
                                normal: { //默认样式
                                    label: {
                                        show: true
                                    },
                                },
                                emphasis: {//高亮状态

                                }
                            },
                            lineStyle: { //关系边的公用线条样式。
                                normal: {
                                    color: '#31354B',
                                    width: '1',
                                    type: 'solid', //线的类型 'solid'（实线）'dashed'（虚线）'dotted'（点线）
                                    // curveness : 0, //线条的曲线程度，从0到1
                                    opacity: 1
                                    // 图形透明度。支持从 0 到 1 的数字，为 0 时不绘制该图形。默认0.5
                                },
                                emphasis: {//高亮状态

                                }
                            },
                            label: { //图形上的文本标签
                                normal: {
                                    show: true,//是否显示标签。
                                    position: 'bottom',//标签的位置。['50%', '50%'] [x,y]   'inside'
                                    textStyle: { //标签的字体样式
                                        color: '#2D2F3B', //字体颜色
                                        fontStyle: 'normal',//文字字体的风格 'normal'标准 'italic'斜体 'oblique' 倾斜
                                        fontWeight: 'bolder',//'normal'标准'bold'粗的'bolder'更粗的'lighter'更细的或100 | 200 | 300 | 400...
                                        fontFamily: 'sans-serif', //文字的字体系列
                                        fontSize: 12, //字体大小
                                    },

                                },
                                // emphasis : {//高亮状态
                                //
                                // }
                            },
                            edgeLabel: {//==============线条的边缘标签
                                normal: {
                                    show: true,
                                    textStyle: {
                                        fontSize: 12
                                    },
                                    trigger: 'item',
                                    formatter(x) {
                                        return x.data.flow;
                                    },

                                },
                            },
                            data: [],
                            links: [],//edges是其别名代表节点间的关系数据。
                            categories: [ //symbol name：用于和 legend 对应以及格式化 tooltip 的内容。 label有效
                                {
                                    name: '路由器',
                                    symbol: 'circle',
                                }, {
                                    name: '服务器',
                                    symbol: 'rect'
                                }, {
                                    name: '二层交换机',
                                    symbol: 'rect'
                                }, {
                                    name: '三层交换机',
                                    symbol: 'rect'
                                }
                            ]
                        }]
                },
            }
        },
        props: {
            data: Array,
        },
        mounted() {
            this.init();
        },
        methods: {
            init() {
                this.chart = this.$echarts.init(document.getElementById('topo'));
                this.option.series[0].data = [];
                this.option.series[0].links = [];
                this.option.series[0].data = this.nodes;
                this.option.series[0].links = this.links;
                this.chart.setOption(this.option, true);
                window.addEventListener("resize",
                    () => {  // 通过resize方法来重设图表宽度
                        let myChart = document.getElementById("topo");
                        myChart.style.height = document.body.clientHeight + "px";
                        this.$echarts.init(myChart).resize()
                    })
            },

        },
        watch: {
            data: {
                handler(newV, oldV) {
                    this.nodes = newV[0];
                    this.links = newV[1];
                    this.init();
                },
                deep: true
            },
        }
    }
</script>

<style scoped>

</style>
