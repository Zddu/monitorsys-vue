<template>
    <div style="height: 100%">
        <el-row>
            <el-col :span="24">
                <div class="head">
                    <el-upload
                            :disabled="importDataDisabled"
                            class="upload-pcap"
                            action="/flow/pcaptoarff"
                            :on-error="onError"
                            :on-success="onSuccess"
                            :before-upload="beforeUpload"
                            multiple
                            :show-file-list="false"
                    >
                        <el-button :disabled="importDataDisabled"  size="small" type="success" :icon="importDataicon">
                            {{importDataText}}
                        </el-button>
                    </el-upload>
                    <el-button @click="downArff" style="margin-right: 10px;"  :disabled="ifsuccess"  size="small" type="success">
                        下载转换文件Arff
                    </el-button>
                    <el-upload
                            class="upload-data"
                            action="/"
                            :on-preview="handlePreview"
                            :on-remove="handleRemove"
                            :before-remove="beforeRemove"
                            multiple
                            :show-file-list="false"
                            :limit="3"
                    >
                        <el-button type="primary" size="small">上传数据文件(arff、cvs格式文件)</el-button>
                    </el-upload>
                </div>
            </el-col>
        </el-row>
        <el-row :gutter="10">
            <el-col :span="8">
                <div class="left">
                    <span class="choice">可选择不同算法</span>
                    <el-select size="small" v-model="value" placeholder="选择算法">
                        <el-option
                                v-for="item in options"
                                :key="item.value"
                                :label="item.label"
                                :value="item.value">
                        </el-option>
                    </el-select>
                    <div class="graph">
                        <span style="display: block;">可选择不同图形展示</span><br/>
                        <el-radio-group class="radio" v-model="form.graph">
                            <el-radio label="饼状图" ></el-radio>
                            <el-radio label="柱状图"></el-radio>
                            <el-radio label="线状图"></el-radio>
                            <el-radio label="散点图"></el-radio>
                            <el-radio label="雷达图"></el-radio>
                        </el-radio-group>
                    </div>
                    <el-divider><i class="el-icon-data-analysis"></i></el-divider>
                    <div class="analysis">
                        <el-form  ref="form" size="small" :model="form" label-width="100px">
                            <el-form-item label="算法描述">
                               <span>
                                基于从上到下的策略，递归的分治策略，
                                   选择某个属性放置在根节点，为每个可能的属性值产生一个分支，
                                   将实例分成多个子集，每个子集对应一个根节点的分支，然后在每个分支上递归地重复这个过程。
                                   当所有实例有相同的分类时，停止。
                               </span>
                            </el-form-item>
                            <el-form-item label="算法准确度">
                                <span style="float: left">99.7%</span>
                            </el-form-item>
                        </el-form>
                    </div>
                </div>
            </el-col>
            <el-col :span="16">
                <div class="right">
                    <PieFlowAnalysis id="pie" />
                </div>
            </el-col>
        </el-row>
    </div>
</template>

<script>
    import PieFlowAnalysis from "../../components/flow/PieFlowAnalysis";
    export default {
        name: "FlowClassify",
        components: {PieFlowAnalysis},
        data() {
            return {
                ifsuccess:true,
                form:{
                  graph:'饼状图'
                },
                importDataText:'上传pcap文件',
                importDataicon:'el-icon-upload2',
                importDataDisabled:false,
                options:[
                    {
                        label:'决策树之J48算法',
                        value:'J48'
                    },{
                        label:'K-最邻算法',
                        value:'KNN'
                    },
                ],
                value:'决策树之J48算法',
            };
        },
        methods: {
            downArff(){
                window.open("/flow/downarff","_parent")
            },
            onError(){
                this.importDataText = '上传pcap文件';
                this.importDataicon = 'el-icon-upload2';
                this.importDataDisabled = false;
            },
            onSuccess(response, file, fileList){
                this.importDataText = '上传pcap文件';
                this.importDataicon = 'el-icon-upload2';
                this.importDataDisabled = false;
                if (response.status===200){
                    this.$message.success({message: response.msg})
                    this.ifsuccess=false;
                }else {
                    this.$message.error({message: response.msg});
                }
            },
            beforeUpload(){
                this.importDataText = '正在转换中...';
                this.importDataicon = 'el-icon-loading';
                this.importDataDisabled = true;
                this.ifsuccess=true;
            },
            handleRemove(file, fileList) {
                console.log(file, fileList);
            },
            handlePreview(file) {
                console.log(file);
            },

            beforeRemove(file, fileList) {
                return this.$confirm(`确定移除 ${file.name}？`);
            }
        }
    }
</script>

<style>
    .head {
        display: flex;
        border: 1px solid #e2e2e2;
        box-sizing: border-box;
        padding: 5px;
        border-radius: 5px;
        margin-bottom: 10px;
    }

    .head .upload-pcap {
        margin-right: 10px;
    }
    .left{
        width: 100%;
        border: 1px solid #e2e2e2;
        box-sizing: border-box;
        border-radius: 5px;
        padding: 20px 0px 0px 0px;
        text-align: center;
        height: 550px;
    }
    .left .choice{
        margin-right: 10px;
    }
    .left .graph{
        margin-top: 10px;
        width:70% ;
        display: inline-block;
    }
    .radio{
        line-height: 40px!important;
    }

    .right{
        width: 100%;
        border: 1px solid #e2e2e2;
        box-sizing: border-box;
        border-radius: 5px;
        height: 550px;
    }
    .analysis{
        padding: 10px;
        box-sizing: border-box;
    }
</style>
