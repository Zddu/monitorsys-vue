<template>
    <div class="main_head">
        <div style="width: 340px">
            <ul :class="ulStyle===1?ulStyle1:ulStyle2">
                <el-scrollbar class="default-scrollbar" wrap-class="default-scrollbar__wrap"
                              view-class="p20-scrollbar__view" :native="false">
                    <li style="font-size: 20px;margin: 0 auto;color: #b6c3ff;cursor: default">选择模型训练算法</li>
                    <li :style="item.id===choiceName?color1:color2" @click="choice(item.id,item.zhName)"
                        v-for="item in algorithmList" :title="item.description">{{item.zhName}}
                    </li>
                </el-scrollbar>
            </ul>
        </div>
        <div style="width: 450px">
            <div class="center_style">
                <div style="width: 100%">
                    <el-upload
                            action="/flow/updataset"
                            :key="1"
                            :disabled="trainDataDisabled"
                            :on-error="onErrorTrain"
                            :on-success="onSuccessTrain"
                            :before-upload="beforeUploadTrain"
                            :show-file-list="false"
                    >
                        <el-button style="width: 80%" :disabled="trainDataDisabled" type="success" :icon="upARFFicon">
                            {{trainDataText}}
                        </el-button>
                    </el-upload>
                </div>
                <div style="width: 100%;">
                    <div v-show="!start">
                        <i style="font-size: 300px;color: #66b1ff;" class="iconfont icon-weibiaoti--"></i>
                    </div>
                    <div v-show="start">
                        <svg  version="1.1" id="L1" xmlns="http://www.w3.org/2000/svg"
                             xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 100 100"
                             enable-background="new 0 0 100 100" xml:space="preserve">
                                <circle fill="none" stroke="#66b1ff" stroke-width="6" stroke-miterlimit="15" stroke-dasharray="14.2472,14.2472" cx="50"
                                        cy="50" r="47">
                                  <animateTransform
                                          attributeName="transform"
                                          attributeType="XML"
                                          type="rotate"
                                          dur="5s"
                                          from="0 50 50"
                                          to="360 50 50"
                                          repeatCount="indefinite"/>
                              </circle>
                               <circle fill="none" stroke="#66b1ff" stroke-width="1" stroke-miterlimit="10"
                                                                stroke-dasharray="10,10" cx="50" cy="50" r="39">
                                  <animateTransform
                                          attributeName="transform"
                                          attributeType="XML"
                                          type="rotate"
                                          dur="5s"
                                          from="0 50 50"
                                          to="-360 50 50"
                                          repeatCount="indefinite"/>
                              </circle>
                              <g fill="#66b1ff">
                              <rect x="30" y="35" width="5" height="30">
                                <animateTransform
                                        attributeName="transform"
                                        dur="1s"
                                        type="translate"
                                        values="0 5 ; 0 -5; 0 5"
                                        repeatCount="indefinite"
                                        begin="0.1"/>
                              </rect>
                              <rect x="40" y="35" width="5" height="30">
                                <animateTransform
                                        attributeName="transform"
                                        dur="1s"
                                        type="translate"
                                        values="0 5 ; 0 -5; 0 5"
                                        repeatCount="indefinite"
                                        begin="0.2"/>
                              </rect>
                               <rect x="50" y="35" width="5" height="30">
                                <animateTransform
                                        attributeName="transform"
                                        dur="1s"
                                        type="translate"
                                        values="0 5 ; 0 -5; 0 5"
                                        repeatCount="indefinite"
                                        begin="0.3"/>
                              </rect>
                               <rect x="60" y="35" width="5" height="30">
                                <animateTransform
                                        attributeName="transform"
                                        dur="1s"
                                        type="translate"
                                        values="0 5 ; 0 -5; 0 5"
                                        repeatCount="indefinite"
                                        begin="0.4"/>
                              </rect>
                               <rect x="70" y="35" width="5" height="30">
                                <animateTransform
                                        attributeName="transform"
                                        dur="1s"
                                        type="translate"
                                        values="0 5 ; 0 -5; 0 5"
                                        repeatCount="indefinite"
                                        begin="0.5"/>
                              </rect>
                              </g>
                            </svg>
                    </div>
                </div>
                <div style="width: 100%">
                    <el-button type="primary" style="width: 80%;height: 100px" @click="startTrain()"
                               :disabled="ifTrain">
                        {{startT}}
                    </el-button>
                </div>
            </div>
        </div>
        <div style="width: 520px">
            <div class="right_result">
                <div style="margin: 0 auto">
                    <h3>模型评估结果</h3>
                    <p> Correctly Classified Instances：{{result.totalNumberOfInstances-result.incorrect}} </p>
                    <p> Incorrectly Classified Instances：{{result.incorrect}} </p>
                    <p> percentage of Correct：{{result.pctCorrect}} %</p>
                    <p> percentage of Incorrect：{{result.correctRate}} %</p>
                    <p> Kappa statistic：{{result.kappa}} </p>
                    <p> Weighted Recall：{{result.weightedRecall}}% </p>
                    <p> Average Cost：{{result.avgCost}} </p>
                    <p> Mean absolute error：{{result.meanAbsoluteError}}% </p>
                    <p> Root mean squared error：{{result.rootMeanSquaredError}} %</p>
                    <p> Relative absolute error：{{result.relativeAbsoluteError}} %</p>
                    <p> Root relative squared error：{{result.rootRelativeSquaredError}}% </p>
                    <p> Root Mean Prior Squared Error：{{result.rootMeanPriorSquaredError}}% </p>
                    <p> percentage of Unclassified：{{result.pctUnclassified}} %</p>
                    <p> Total Number of Instances：{{result.totalNumberOfInstances}} </p>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "ModelTrain",
        data() {
            return {
                startT: '开始训练',
                upARFFicon: 'el-icon-upload2',
                trainDataDisabled: false,
                trainDataText: '上传ARFF数据集',
                ifTrain: true,
                start: false,
                algorithmList: [],
                choiceName: '',
                color1: '',
                color2: '',
                noChoice: true,
                ulStyle1: 'left_list',
                ulStyle2: 'left_list notClick',
                ulStyle: 1,
                result: {},
            }
        },
        mounted() {
            this.getAllAlgs();
        },
        methods: {
            getAllAlgs() {
                this.getRequest("/flow/getalgs").then(res => {
                    this.algorithmList = res;
                })
            },
            startTrain() {
                this.ulStyle = 2;
                this.startT = '正在训练中...';
                this.start = !this.start;
                this.ifTrain = true;
                this.getRequest("/flow/start").then(res => {
                    if (res) {
                        this.getResult();
                    }
                    this.start = false;
                    this.ulStyle = 1;
                    this.startT = '开始训练';
                    this.ifTrain = false;
                })
            },
            getResult() {
                this.getRequest("/flow/evaluation").then(res => {
                    this.result = res;
                })
            },
            choice(name, zhname) {
                this.choiceName = name;
                this.color1 = ' color:#409eff;';
                this.getRequest("/flow/getchoicealgs?choice=" + name).then(res => {
                })
            },
            onErrorTrain() {
                this.trainDataText = '上传ARFF数据集';
                this.upARFFicon = 'el-icon-upload2';
                this.trainDataDisabled = false;
                this.ifTrain = true;
            },
            onSuccessTrain(response, file, fileList) {
                this.trainDataText = '上传ARFF数据集';
                this.upARFFicon = 'el-icon-upload2';
                this.trainDataDisabled = false;
                if (response.status === 200) {
                    this.ifTrain = false;
                    this.$message.success({message: response.msg})
                } else {
                    this.$message.error({message: response.msg});
                }
            },
            beforeUploadTrain() {
                this.trainDataText = '正在上传中...';
                this.upARFFicon = 'el-icon-loading';
                this.trainDataDisabled = true;
            },
        }
    }
</script>

<style>
    svg {
        width: 300px;
        height: 300px;
        display: inline-block;
    }

    .main_head {
        width: 1330px;
        display: flex;
        justify-content: space-between;
    }

    .el-carousel__item h3 {
        color: #475669;
        font-size: 50px;
        opacity: 0.75;
        line-height: 300px;
        margin: 0;

    }

    .small {
        word-break: break-all;
        overflow: hidden;
        word-wrap: break-word;
    }

    .right_result {
        border: 1px solid #eaeaea;
        width: 100%;
        height: 600px;
        display: flex;

    }

    .left_list {
        height: 600px;
        border: 1px solid #eaeaea;
        box-sizing: border-box;
        margin: 0 !important;
    }

    .notClick {
        pointer-events: none;
        background: #27272791;
    }

    .left_list li {
        width: 100%;
        height: 36px;
        line-height: 36px;
        font-size: 16px;
    }

    .left_list li:hover {
        color: #409eff;
        cursor: pointer;
    }

    .center_style {
        border: 1px solid #eaeaea;
        width: 100%;
        height: 600px;
        padding: 10px;
        box-sizing: border-box;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-direction: column;
    }
</style>
