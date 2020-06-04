<template>
    <div class="main_head">
            <div style="width: 340px">
                <ul :class="ulStyle===1?ulStyle1:ulStyle2">
                    <el-scrollbar class="default-scrollbar" wrap-class="default-scrollbar__wrap"
                                  view-class="p20-scrollbar__view" :native="false">
                        <li style="font-size: 20px;margin: 0 auto;color: #b6c3ff;cursor: default">选择模型训练算法</li>
                        <li  :style="item.name===choiceName?color1:color2" @click="choice(item.name,item.zhName)" v-for="item in algorithmList" :title="item.description">{{item.zhName}}</li>
                    </el-scrollbar>
                </ul>
            </div>
            <div style="width: 450px">
                <div class="center_style">
                    <div style="width: 100%">
                        <el-upload
                                :key="1"
                                :disabled="trainDataDisabled"
                                action=""
                                :on-error="onErrorTrain"
                                :on-success="onSuccessTrain"
                                :before-upload="beforeUploadTrain"
                                :show-file-list="false"
                        >
                            <el-button style="width: 80%" :disabled="trainDataDisabled"   type="success" :icon="upARFFicon">
                                {{trainDataText}}
                            </el-button>
                        </el-upload>
                    </div>
                    <div style="width: 100%;">
                        <div v-show="!start">
                            <i style="font-size: 200px;color: #66b1ff;" class="iconfont icon-weibiaoti--"></i>
                        </div>
                        <el-carousel v-show="start" arrow="never" indicator-position="none" height="300px">
                            <el-carousel-item >
                                <h3 class="small">正在进行模型训练...</h3>
                            </el-carousel-item>
                            <el-carousel-item >
                                <h3 class="small">请稍等...</h3>
                            </el-carousel-item>
                            <el-carousel-item >
                                <h3 class="small">{{choiceName}}</h3>
                            </el-carousel-item>
                        </el-carousel>
                    </div>
                    <div style="width: 100%">
                        <el-button  type="primary" style="width: 80%;height: 100px" @click="startTrain()" :disabled="ifTrain">开始训练</el-button>
                    </div>
                </div>
            </div>
            <div style="width: 520px">
                <div class="right_result">
                    <div style="margin: 0 auto">
                        <h3 >模型评估结果</h3>

                        <h4> Evaluation: </h4>
                         <p>   Correctly Classified Instances         756               98.8235 %</p>
                        <p>  Incorrectly Classified Instances         9                1.1765 %</p>
                        <p>  Kappa statistic                          0.9531</p>
                        <p>  K&B Relative Info Score                 88.1401 %</p>
                        <p>   K&B Information Score                  633.9309 bits      0.8287 bits/instance</p>
                        <p>   Class complexity | order 0             719.2307 bits      0.9402 bits/instance</p>
                        <p>   Class complexity | scheme             5413.6621 bits      7.0767 bits/instance</p>
                        <p>   Complexity improvement     (Sf)      -4694.4314 bits     -6.1365 bits/instance</p>
                        <p>   Mean absolute error                      0.0011</p>
                        <p>   Root mean squared error                  0.0301</p>
                        <p>   Relative absolute error                  4.3438 %</p>
                        <p>  Root relative squared error             27.8072 %</p>
                        <p>   Total Number of Instances              765</p>
                    </div>
                </div>
            </div>
    </div>
</template>

<script>
    export default {
        name: "ModelTrain",
        data(){
          return{
              upARFFicon:'el-icon-upload2',
              trainDataDisabled:false,
              trainDataText:'上传ARFF数据集',
              ifTrain:true,
              start:false,
              algorithmList:[],
              choiceName:'',
              color1:'',
              color2:'',
              noChoice:true,
              ulStyle1:'left_list',
              ulStyle2:'left_list notClick',
              ulStyle:1,
          }
        },
        mounted(){
            this.getAllAlgs();
        },
        methods:{
            getAllAlgs(){
              this.getRequest("/flow/getalgs").then(res=>{
                  this.algorithmList=res;
              })
            },
            startTrain(){
              this.start=!this.start;
              this.ulStyle=2;
            },
            choice(name,zhname){
                this.choiceName = name;
                this.color1=' color:#409eff;';
            },
            onErrorTrain(){
                this.trainDataText = '上传ARFF数据集';
                this.upARFFicon = 'el-icon-upload2';
                this.trainDataDisabled = false;
                this.ifTrain=true;
            },
            onSuccessTrain(response, file, fileList){
                this.trainDataText = '上传ARFF数据集';
                this.upARFFicon = 'el-icon-upload2';
                this.trainDataDisabled = false;
                if (response.status===200){
                    this.ifTrain=false;
                    this.$message.success({message: response.msg})
                }else {
                    this.$message.error({message: response.msg});
                }
            },
            beforeUploadTrain(){
                this.trainDataText = '正在上传中...';
                this.upARFFicon = 'el-icon-loading';
                this.trainDataDisabled = true;
            },
        }
    }
</script>

<style>
    .main_head{
        width: 1330px;
        display: flex;
        justify-content: space-between;
    }
    .el-carousel__item h3 {
        color: #475669;
        font-size:50px;
        opacity: 0.75;
        line-height: 300px;
        margin: 0;

    }
    .small{
        word-break: break-all;
        overflow: hidden;
        word-wrap: break-word;
    }
    .right_result{
        border: 1px solid #eaeaea;
        width: 100%;
        height: 600px;
        display: flex;

    }
    .left_list {
        height: 600px;
        border: 1px solid #eaeaea;
        box-sizing: border-box;
        margin: 0!important;
    }
    .notClick{
        pointer-events: none;
        background: #27272791;
    }
    .left_list li {
        width: 100%;
        height: 36px;
        line-height: 36px;
        font-size: 16px;
    }
    .left_list li:hover{
        color:#409eff;
        cursor: pointer;
    }
    .center_style{
        border: 1px solid #eaeaea;
        width: 100%;
        height: 600px;
        padding: 10px;
        box-sizing: border-box;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content:space-between;
        flex-direction:column;
    }
</style>
