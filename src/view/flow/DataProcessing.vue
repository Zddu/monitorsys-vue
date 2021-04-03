<template>
    <div>
        <el-row :gutter="20">
            <el-col :span="12">
                <el-divider>PCAP to CSV</el-divider>
                <div class="main_pro" style="height: 700px">
                    <el-form ref="form" :rules="rules" :model="form" label-width="80px">
                        <el-form-item label="上传文件">
                            <el-upload
                                    :key="1"
                                    :disabled="importDataDisabled"
                                    action="/flow/upprocessing"
                                    :on-error="onError"
                                    :on-success="onSuccess"
                                    :before-upload="beforeUpload"
                                    :show-file-list="false"
                            >
                                <el-button style="width: 100%" size="small" :disabled="importDataDisabled"   type="success" :icon="importDataicon">
                                    {{importDataText}}
                                </el-button>
                            </el-upload>
                        </el-form-item>
                        <el-form-item label="当前标签" prop="label">
                                <el-input placeholder="当前数据文件的类别标签，该标签应包含于标签集" size="small" style="width: 100%" v-model="form.label"></el-input>
                        </el-form-item>
                        <el-form-item>
                            <el-button size="small" style="width: 100%" type="primary" @click="submitForm('form')">
                                开始转换
                            </el-button>
                        </el-form-item>
                        <el-form-item>
                            <el-button size="small" :disabled="!nums>0" style="width: 100%;" type="primary" @click="downCSV()">
                                数据加工完毕下载CSV
                            </el-button>
                        </el-form-item>
                    </el-form>
<!--                    <span style="width: 80px;display: inline-block;margin-left: 10px">累计次数</span>{{nums}}<br>-->
                    <el-divider>PCAP生成未知标签ARFF文件</el-divider>
                    <el-form ref="unlabeled" :rules="rules"  :model="unlabeled" label-width="80px">
                        <el-form-item label="上传PCAP">
                            <el-upload
                                    ref="uploadunlabeled"
                                    :key="2"
                                    :disabled="importDataUnlabeled"
                                    drag
                                    action="/flow/uparffunlabel"
                                    :data="upData"
                                    :on-error="onErrorUnlabeled"
                                    :on-success="onSuccessUnlabeled"
                                    :before-upload="beforeUploadUnlabeled"
                                    :auto-upload="false"
                            >
                                <i class="el-icon-upload"></i>
                                <div class="el-upload__text">{{importDataTextUnlabled}}</div>
                            </el-upload>
                        </el-form-item>
                        <el-form-item label="标签集" prop="labels">
                            <el-tooltip effect="dark" content="数据集的所有分类标签,以%号隔开如:A%B%C" placement="top">
                                <el-input type="textarea" placeholder="格式:A%B%C" size="small" style="width: 100%"
                                          v-model="unlabeled.labels"></el-input>
                            </el-tooltip>
                        </el-form-item>
                        <el-form-item>
                            <el-button size="small"  style="width: 100%;" type="primary"  @click="submitNoLabel('unlabeled')">
                                开始转换
                            </el-button>
                        </el-form-item>
                        <el-form-item>
                            <el-button size="small" :disabled="ifconvert" style="width:100%;" type="primary" @click="downARFFNoLabel()">
                                数据转换完毕下载ARFF
                            </el-button>
                        </el-form-item>
                    </el-form>
                </div>
            </el-col>
            <el-col :span="12">
                <el-divider>CSV to ARFF</el-divider>
                <div class="main_pro" style="text-align: center">
                    <el-upload
                            :key="3"
                            style="margin-bottom: 80px;"
                            class="upload-demo"
                            drag
                            :show-file-list="false"
                            :on-error="onErrorDrag"
                            :on-success="onSuccessDrag"
                            :before-upload="beforeUploadDrag"
                             action="/flow/csvtoarff"
                            :disabled="UpDataDrag"
                            >
                        <i class="el-icon-upload"></i>
                        <div class="el-upload__text">{{DragText}}</div>
                    </el-upload>
                    <el-divider>转换完毕后即可下载</el-divider>

                    <el-button  @click="downArff" style="margin:50px 10px;width: 90%"  :disabled="ifsuccess"  size="small" type="success">
                        下载转换文件Arff
                    </el-button>
                </div>
            </el-col>
        </el-row>
    </div>
</template>

<script>
    export default {
        name: "DataProcessing",
        data(){
            return{
                ifconvert:true,
                importDataUnlabeled:false,
                DragText:'将文件拖到此处，或点击上传',
                importDataTextUnlabled:'将文件拖到此处，或点击上传',
                UpDataDrag:false,
                form: {
                    labels: '',
                    label: '',
                    head: '否',
                },
                unlabeled:{
                    labels:'',
                },
                nums:0,
                ifsuccess:true,
                importDataText:'上传pcap文件',
                importDataicon:'el-icon-upload2',
                importDataiconUnlabeled:'el-icon-upload2',
                importDataDisabled:false,
                rules: {
                    labels: [
                        { required: true, message: '请输入标签集', trigger: 'change' }
                    ],
                    label: [
                        { required: true, message: '请输入当前数据标签', trigger: 'blur' }
                    ]
                }
            }
        },
        computed: {
            // 这里定义上传文件时携带的参数，即表单数据
            upData: function() {
                return {
                    body: this.unlabeled.labels
                }
            }
        },
        methods:{
            downArff(){
                window.open("/flow/downarff","_parent");
            },
            downARFFNoLabel(){
                window.open("/flow/downarffunlabel","_parent");
            },
            downCSV(){
                this.nums=0;
                window.open("/flow/downcsv","_parent");
            },
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        this.getRequest("/flow/tocsv?label="+this.form.label).then(res=>{
                            if (res) {
                                this.nums++;
                            }
                            this.form.label='';
                        })
                    } else {
                        return false;
                    }
                });
            },
            submitNoLabel(formName){
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        this.$refs.uploadunlabeled.submit();
                    } else {
                        return false;
                    }
                    this.unlabeled.labels='';
                });
            },
            onErrorUnlabeled(){
                this.importDataTextUnlabled = '上传pcap文件';
                this.importDataiconUnlabeled = 'el-icon-upload2';
                this.importDataUnlabeled = false;

            },
            onSuccessUnlabeled(response, file, fileList){
                this.importDataTextUnlabled = '上传pcap文件';
                this.importDataiconUnlabeled = 'el-icon-upload2';
                this.importDataUnlabeled = false;
                if (response.status===200){
                    this.ifconvert=false;
                    this.$message.success({message: response.msg})
                }else {
                    this.$message.error({message: response.msg});
                }
            },
            beforeUploadUnlabeled(){
                this.importDataTextUnlabled = '正在上传中...';
                this.importDataiconUnlabeled = 'el-icon-loading';
                this.importDataUnlabeled = true;
                this.ifconvert=true;
            },
            onError(){
                this.importDataText = '上传pcap文件';
                this.importDataicon = 'el-icon-upload2';
                this.importDataDisabled = false;
                this.ifconvert=true;

            },
            onSuccess(response, file, fileList){
                this.importDataText = '上传pcap文件';
                this.importDataicon = 'el-icon-upload2';
                this.importDataDisabled = false;
                if (response.status===200){
                    this.$message.success({message: response.msg})
                }else {
                    this.$message.error({message: response.msg});
                }
            },
            beforeUpload(){
                this.form.label='';
                this.importDataText = '正在上传中...';
                this.importDataicon = 'el-icon-loading';
                this.importDataDisabled = true;
            },
            onErrorDrag(){
                this.DragText = '将文件拖到此处，或点击上传';
                this.UpDataDrag = false;
            },
            beforeUploadDrag(){
                this.DragText = '正在转换中...';
                this.UpDataDrag = true;
                this.ifsuccess=true;
            },
            onSuccessDrag(response, file, fileList){
                this.DragText = '将文件拖到此处，或点击上传';
                this.UpDataDrag = false;
                if (response.status===200){
                    this.ifsuccess=false;
                    this.$message.success({message: response.msg})
                }else {
                    this.$message.error({message: response.msg});
                }
            },
        }
    }
</script>

<style>
    .main_pro {
        height: 550px;
        width: 100%;
        border: 1px solid #eaeaea;
        border-radius: 5px;
        padding: 5px;
        box-sizing: border-box;
    }
    .el-upload--text{
        width: 100% !important;
    }
    .el-upload-dragger{
        width: 100%!important;
    }
</style>
