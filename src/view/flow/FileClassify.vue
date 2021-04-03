<template>
    <div>
        <el-row>
            <el-col :span="24">
                <div class="file_head">
                    <el-upload
                            :disabled="importDataDisabled"
                            action="/flow/classifynot"
                            :on-error="onError"
                            :on-success="onSuccess"
                            :before-upload="beforeUpload"
                            :show-file-list="false"
                    >
                        <el-button style="margin-right: 10px;" :disabled="importDataDisabled" size="small"
                                   type="primary" :icon="importDataicon">
                            {{importDataText}}
                        </el-button>
                    </el-upload>
                    <div class="in_flex">
                        <div>
                            <el-button @click="startClassify" style="margin-right: 10px;" size="small" type="success">
                                开始分类
                            </el-button>
                        </div>
                        <div>
                            <el-button @click="downARFF" style="margin-right: 10px;" :disabled="ifsuccess" size="small"
                                       type="primary">
                                下载分类完毕的ARFF文件
                            </el-button>
                            <el-button @click="downCSV" style="margin-right: 10px;" :disabled="ifsuccess" size="small"
                                       type="primary">
                                下载分类完毕的CSV文件
                            </el-button>
                        </div>
                    </div>
                </div>
            </el-col>
        </el-row>
        <el-row :gutter="10">
            <el-col :span="6">
                <div class="left_file">
                    <ul :class="ulStyle===1?ulStyle1:ulStyle2">
                        <el-scrollbar class="default-scrollbar" wrap-class="default-scrollbar__wrap"
                                      view-class="p20-scrollbar__view" :native="false">
                            <li style="font-size: 20px;margin: 0 auto;color: #b6c3ff;cursor: default">选择已训练的模型</li>
                            <li :style="item.id===choiceName?color1:color2" @click="choice(item.id)"
                                v-for="item in model" :title="item.description">{{item.zhName}}模型
                            </li>
                        </el-scrollbar>
                    </ul>
                </div>
            </el-col>
            <el-col :span="18">
                <div class="graph_style">
                    <el-button type="success" :disabled="graphStyle" @click="barGraph" plain size="small">柱状图</el-button>
                    <el-button type="success" :disabled="graphStyle" @click="lineGraph" plain size="small">折线图</el-button>
                    <el-button type="success" :disabled="graphStyle" @click="pieGraph" plain size="small">饼状图</el-button>
                    <el-button type="success" :disabled="graphStyle" @click="formGraph" plain size="small">表格</el-button>
                </div>
                <div class="right_file">
                    <span v-show="nodata" style="font-size: 60px;color: #8ea09f;">暂无分类结果</span>

                    <PieFlowAnalysis v-if="ifshow" :data="data" id="pie"/>
                    <BarFlowAnalysis v-if="isbar" :data="data" id="bar"/>
                    <LineFlowAnalysis v-if="isline" :data="data" id="line"/>
                    <FormFlowAnalysis v-show="isform" />
                </div>
            </el-col>
        </el-row>

    </div>
</template>

<script>
    import PieFlowAnalysis from "../../components/flow/PieFlowAnalysis";
    import BarFlowAnalysis from "../../components/flow/BarFlowAnalysis";
    import LineFlowAnalysis from "../../components/flow/LineFlowAnalysis";
    import FormFlowAnalysis from "../../components/flow/FormFlowAnalysis";

    export default {
        name: "FileClassify",
        components: {FormFlowAnalysis, LineFlowAnalysis, BarFlowAnalysis, PieFlowAnalysis},
        data() {
            return {
                nodata: true,
                isline: false,
                isbar: false,
                isform:false,
                graphStyle: true,
                importDataDisabled: false,
                importDataicon: 'el-icon-upload2',
                importDataText: '上传未加标签的ARFF文件',
                ifsuccess: true,
                ulStyle1: 'left_list1',
                ulStyle2: 'left_list1 notClick1',
                ulStyle: 1,
                model: [],
                color1: '',
                color2: '',
                choiceName: '',
                ifshow: false,
                data: [],
            }
        },
        mounted() {
            this.getModelList();
        },
        methods: {
            formGraph(){

            },
            barGraph() {
                this.ifshow = false;
                this.isbar = true;
                this.isline = false;
                this.getClssifyResult();
            },
            lineGraph() {
                this.ifshow = false;
                this.isbar = false;
                this.isline = true;
                this.getRequest("/flow/bardata").then(res=>{
                    console.log(res);
                    this.data = res;
                })
            },
            pieGraph() {
                this.ifshow = true;
                this.isbar = false;
                this.isline = false;
                this.getClssifyResult();
            },
            downARFF() {
                window.open("/flow/downlabeledarff", "_parent")
            },
            downCSV() {
                window.open("/flow/downlabeled", "_parent")
            },
            getClssifyResult() {
                this.getRequest("/flow/classifyresult").then(res => {
                    this.data = res;
                })
            },
            startClassify() {
                this.getRequest("/flow/startclassify").then(res => {
                    if (res) {
                        this.getClssifyResult();
                        this.nodata = false;
                        this.ifshow = true;
                        this.graphStyle = false;
                    }
                })
            },
            getModelList() {
                this.getRequest("/flow/getmodels").then(res => {
                    this.model = res;
                })
            },
            choice(id) {
                this.choiceName = id;
                this.color1 = ' color:#409eff;';
                this.getRequest("/flow/choicemodel?model=" + id).then(res => {
                })
            },
            onError() {
                this.importDataText = '上传未加标签的ARFF文件';
                this.importDataicon = 'el-icon-upload2';
                this.importDataDisabled = false;
            },
            onSuccess(response, file, fileList) {
                this.importDataText = '上传未加标签的ARFF文件';
                this.importDataicon = 'el-icon-upload2';
                this.importDataDisabled = false;
                if (response.status === 200) {
                    this.$message.success({message: response.msg});
                    this.ifsuccess = false;
                } else {
                    this.$message.error({message: response.msg});
                }
            },
            beforeUpload() {
                this.importDataText = '正在上传中...';
                this.importDataicon = 'el-icon-loading';
                this.importDataDisabled = true;
                this.ifsuccess = true;
            },
        }
    }
</script>

<style>
    .graph_style {
        border: 1px solid #e2e2e2;
        border-radius: 5px;
        box-sizing: border-box;
        padding: 5px;
        margin-bottom: 10px;
    }

    .right_file {
        width: 100%;
        border: 1px solid #e2e2e2;
        box-sizing: border-box;
        border-radius: 5px;
        height: 500px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .left_file {
        width: 100%;
        border: 1px solid #e2e2e2;
        box-sizing: border-box;
        border-radius: 5px;
        padding: 20px 0px 0px 0px;
        height: 555px;
    }

    .left_list1 li {
        width: 100%;
        height: 36px;
        line-height: 36px;
        font-size: 16px;
    }

    .left_list1 li:hover {
        color: #409eff;
        cursor: pointer;
    }

    .left_list1 {
        height: 100%;
        margin: 0 !important;
    }

    .notClick1 {
        pointer-events: none;
        background: #27272791;
    }

    .file_head {
        display: flex;
        border: 1px solid #e2e2e2;
        box-sizing: border-box;
        padding: 5px;
        border-radius: 5px;
        margin-bottom: 10px;
    }

    .in_flex {
        width: 100%;
        display: flex;
        justify-content: space-between;
    }
</style>
