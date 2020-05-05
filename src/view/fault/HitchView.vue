<template>
    <el-container direction="vertical" style="width:100%;">
        <el-container style="width:100%;display: flex;">
            <div style="width: 100%">
                <div class="HVContent" style="width: 100%">
                    <div class="HVContentTabs" style="width: 100%">
                        <span style="float: left;margin-top: 3px;margin-right: 30px;font-family: 微软雅黑;font-size: 25px;">故障视图</span>
                        <el-tabs v-model="activeName" type="card">
                            <el-tab-pane label="未处理告警" name="first">
                                <div class="HRContentTabs">
                                    <el-table
                                            ref="multipleTable"
                                            :data="tableData.filter(data => !search || data.check.zhtype.toLowerCase().includes(search.toLowerCase()))"
                                            height="500"
                                            size="mini"
                                            v-loading="loading1"
                                            tooltip-effect="dark"
                                            style="width: 100%"
                                            id="table1"
                                            @selection-change="handleSelection1">
                                        <el-table-column
                                                type="selection"
                                                width="55">
                                        </el-table-column>
                                        <el-table-column
                                                prop="rank"
                                                label="状态"
                                                width="120">
                                            <template slot-scope="scope">
                                                <span :class="scope.row.rank==='故障'? classStyle1:classStyle2"></span>
                                                <span>{{ scope.row.rank }}</span>
                                            </template>
                                        </el-table-column>
                                        <el-table-column
                                                prop="ip"
                                                label="节点"
                                        >
                                        </el-table-column>
                                        <el-table-column
                                                prop="check.zhtype"
                                                label="检测点"
                                        >
                                        </el-table-column>
                                        <el-table-column
                                                prop="frequency"
                                                label="次数"
                                                width="100">
                                        </el-table-column>
                                        <el-table-column
                                                prop="time"
                                                label="开始时间"
                                        >
                                        </el-table-column>
                                        <el-table-column
                                                prop="newTime"
                                                label="最新时间"
                                        >
                                        </el-table-column>
                                        <el-table-column
                                                prop="cause"
                                                label="详细"
                                                type="expand"
                                                width="80">
                                            <template slot-scope="props">
                                                <el-form size="small" label-position="left" inline
                                                         class="demo-table-expand">
                                                    <el-form-item size="small" label="详细信息">
                                                        <span>{{ props.row.cause }}</span>
                                                    </el-form-item>
                                                </el-form>
                                            </template>
                                        </el-table-column>
                                        <el-table-column
                                                prop="operation"
                                                width="200">
                                            <template slot="header" slot-scope="scope">
                                                <el-input
                                                        v-model="search"
                                                        size="mini"
                                                        placeholder="输入监测点关键字搜索"/>
                                            </template>
                                            <template slot-scope="scope">
                                                <el-button @click.stop="doJob(scope.row)" type="text" size="small">处理
                                                </el-button>
                                                <el-button @click.stop="ignorance(scope.row)" type="text" size="small">
                                                    忽略
                                                </el-button>
                                            </template>
                                        </el-table-column>
                                    </el-table>
                                    <div style="width: 100%;margin-top: 10px;display: flex;align-items: flex-start">
                                        <el-tag type="success" style="margin-right: 10px;">共{{tableData.length}}条数据
                                        </el-tag>
                                        <el-button @click="selectedProcess" size="small" type="success">处理选中</el-button>
                                        <el-button @click="selectedIngore" size="small" type="warning">忽略选中</el-button>
                                        <el-button @click="selectedDelete" size="small" type="danger">删除选中</el-button>
                                        <el-button @click="exportAll" size="small" type="success">导出所有</el-button>
                                    </div>
                                </div>
                            </el-tab-pane>
                            <el-tab-pane label="正在处理告警" name="second">
                                <el-table
                                        v-loading="loading1"
                                        ref="multipleTable"
                                        height="500"
                                        size="mini"
                                        :data="processed.filter(data => !search || data.check.zhtype.toLowerCase().includes(search.toLowerCase()))"
                                        tooltip-effect="dark"
                                        style="width: 100%"
                                        @selection-change="handleSelection2">
                                    <el-table-column
                                            type="selection"
                                            width="55">
                                    </el-table-column>
                                    <el-table-column
                                            prop="rank"
                                            label="状态"
                                            width="120">
                                        <template slot-scope="scope">
                                            <span class="st-square st-square-success"></span>
                                            <span>{{ scope.row.rank }}</span>
                                        </template>
                                    </el-table-column>
                                    <el-table-column
                                            prop="ip"
                                            label="节点"
                                    >
                                    </el-table-column>
                                    <el-table-column
                                            prop="check.zhtype"
                                            label="检测点"
                                    >
                                    </el-table-column>
                                    <el-table-column
                                            prop="time"
                                            label="开始时间"
                                    >
                                    </el-table-column>
                                    <el-table-column
                                            prop="newtime"
                                            label="最新时间"
                                    >
                                    </el-table-column>
                                    <el-table-column
                                            prop="detailed"
                                            label="详细"
                                            type="expand"
                                            width="80">
                                        <template slot-scope="props">
                                            <el-form size="small" label-position="left" inline
                                                     class="demo-table-expand">
                                                <el-form-item size="small" label="详细信息">
                                                    <span>{{ props.row.cause }}</span>
                                                </el-form-item>
                                            </el-form>
                                        </template>
                                    </el-table-column>
                                    <el-table-column
                                            prop="operation"
                                            width="200">
                                        <template slot="header" slot-scope="scope">
                                            <el-input
                                                    v-model="search"
                                                    size="mini"
                                                    placeholder="输入监测点关键字搜索"/>
                                        </template>
                                        <template slot-scope="scope">
                                            <el-button @click.stop="remark(scope.row)" type="text" size="small">备注
                                            </el-button>
                                            <el-button @click.stop="del(scope.row)" type="text" size="small">删除
                                            </el-button>
                                        </template>
                                    </el-table-column>
                                </el-table>
                                <div style="width: 100%;margin-top: 10px;display: flex;align-items: flex-start">
                                    <el-tag type="success" style="margin-right: 10px;">共{{processed.length}}条数据</el-tag>
                                    <el-button @click="selectedIngore" size="small" type="warning">忽略选中</el-button>
                                    <el-button @click="selectedDelete" size="small" type="danger">删除选中</el-button>
                                    <el-button @click="exportAll1" size="small" type="success">导出所有</el-button>
                                </div>
                            </el-tab-pane>

                            <el-tab-pane label="已忽略告警" name="third">
                                <el-table
                                        v-loading="loading1"
                                        ref="multipleTable"
                                        height="500"
                                        size="mini"
                                        :data="ignored.filter(data => !search || data.check.zhtype.toLowerCase().includes(search.toLowerCase()))"
                                        tooltip-effect="dark"
                                        style="width: 100%"
                                        @selection-change="handleSelection3">
                                    <el-table-column
                                            type="selection"
                                            width="55">
                                    </el-table-column>
                                    <el-table-column
                                            prop="rank"
                                            label="状态"
                                            width="120">
                                        <template slot-scope="scope">
                                            <span class="st-square st-square-ignorance"></span>
                                            <span>{{ scope.row.rank }}</span>
                                        </template>
                                    </el-table-column>
                                    <el-table-column
                                            prop="ip"
                                            label="节点"
                                    >
                                    </el-table-column>
                                    <el-table-column
                                            prop="check.zhtype"
                                            label="检测点"
                                    >
                                    </el-table-column>
                                    <el-table-column
                                            prop="time"
                                            label="开始时间"
                                    >
                                    </el-table-column>
                                    <el-table-column
                                            prop="newtime"
                                            label="最新时间"
                                    >
                                    </el-table-column>
                                    <el-table-column
                                            prop="detailed"
                                            label="详细"
                                            type="expand"
                                            width="80">
                                        <template slot-scope="props">
                                            <el-form size="small" label-position="left" inline
                                                     class="demo-table-expand">
                                                <el-form-item label="详细信息">
                                                    <span>{{ props.row.cause }}</span>
                                                </el-form-item>
                                            </el-form>
                                        </template>
                                    </el-table-column>
                                    <el-table-column
                                            prop="operation"
                                            width="200">
                                        <template slot="header" slot-scope="scope">
                                            <el-input
                                                    v-model="search"
                                                    size="mini"
                                                    placeholder="输入监测点关键字搜索"/>
                                        </template>
                                        <template slot-scope="scope">
                                            <el-button @click.stop="remark(scope.row)" type="text" size="small">备注
                                            </el-button>
                                            <el-button @click.stop="del(scope.row)" type="text" size="small">删除
                                            </el-button>
                                        </template>
                                    </el-table-column>
                                </el-table>
                                <div style="width: 100%;margin-top: 10px;display: flex;align-items: flex-start">
                                    <el-tag type="success" style="margin-right: 10px;">共{{ignored.length}}条数据</el-tag>
                                    <el-button @click="selectedDelete" size="small" type="danger">删除选中</el-button>
                                    <el-button @click="exportAll2" size="small" type="success">导出所有</el-button>
                                </div>
                            </el-tab-pane>
                        </el-tabs>

                        <el-dialog
                                title="批量追加备注"
                                :visible.sync="selectedRemark"
                                width="30%">
                            <div>
                                <el-form>
                                    <el-form-item prop="desc">
                                        <el-input type="textarea" v-model="form.desc"></el-input>
                                    </el-form-item>
                                </el-form>
                            </div>
                            <span slot="footer" class="dialog-footer">
                                <el-button  size="small" @click="selectedRemark = false">取 消</el-button>
                                <el-button  :disabled="sRe" size="small" type="primary" @click="doSelectedRe()" >确 定</el-button>
                            </span>
                        </el-dialog>

                        <el-dialog
                                title="追加备注"
                                :visible.sync="dojob"
                                width="30%">
                            <div>
                                <el-form>
                                    <el-form-item prop="desc">
                                        <el-input type="textarea" v-model="form.desc"></el-input>
                                    </el-form-item>
                                </el-form>
                            </div>
                            <span slot="footer" class="dialog-footer">
                                <el-button  size="small" @click="dojob = false">取 消</el-button>
                                <el-button  :disabled="doBtn" size="small" type="primary" @click="doprocess()" >确 定</el-button>
                            </span>
                        </el-dialog>
                        <el-dialog
                                title="备注信息"
                                :visible.sync="remarkInfo"
                                width="30%">
                            <div>
                                <el-form>
                                    <el-form-item prop="desc">
                                        <el-input type="textarea"  v-model="form.desc"></el-input>
                                    </el-form-item>
                                </el-form>
                            </div>
                            <span slot="footer" class="dialog-footer">
                                <el-button size="small"  @click="remarkInfo = false">取 消</el-button>
                            </span>
                        </el-dialog>
                    </div>
                </div>
            </div>
        </el-container>
    </el-container>
</template>

<script>

    export default {
        name: "HitchView",
        components: {},
        data() {
            return {
                selectedRemark:false,
                sRe:false,
                classStyle1:'st-square st-square-deepred',
                classStyle2:'st-square st-square-warning',
                do:true,
                loading1:true,
                doBtn:false,
                search: '',
                remarkInfo:false,
                form:{
                    devIp:'',
                    desc:'',
                    id:'',
                },
                dojob:false,
                ignored: [],
                tableData: [],
                processed: [],
                multipleSelection: [],
                value: '默认视图',
                activeName: 'first',
                ids:[],
                idsOne:[],
            }
        },
        methods: {
            //导出未处理告警
            exportAll(){
                window.open("/diagnosis/export/unhandledwarnings/","_parent");
            },
            //导出正在处理告警
            exportAll1(){
                window.open("/diagnosis/export/processedwarnings/","_parent");
            },
            //导出已忽略
            exportAll2(){
                window.open("/diagnosis/export/ignorewarnings/","_parent");
            },
            process(row) {

            },
            del(row) {
                this.$confirm('此操作将删除该故障, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    sessionStorage.setItem("notprocess","");
                    this.processed=[];
                    this.deleteRequest("/diagnosis/delete/?id="+row.id).then(res=>{
                        if (res) {
                            this.initD();
                        }
                        this.initD();
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消操作'
                    });
                });

            },
            ignorance(row) {
                this.$confirm('此操作将忽略该故障, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.doBtn = true;
                    sessionStorage.setItem("notprocess","");
                    this.tableData=[];
                    this.postRequest("/diagnosis/ignore/?id="+row.id).then(res=>{
                        if (res) {
                            this.initD();
                        }
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消操作'
                    });
                });

            },
            doJob(row) {
                this.dojob=true;
                this.form.devIp = row.ip;
                this.form.id = row.id;
            },
            doprocess(){
                this.doBtn = true;
                sessionStorage.setItem("notprocess","");
                this.tableData=[];
                this.postRequest("/diagnosis/?desc="+this.form.desc+"&id="+this.form.id).then(res=>{
                    this.dojob = false;
                    this.doBtn = false;
                });
                this.initD();
            },
            remark(row) {
                this.remarkInfo=true;
                this.form.desc='';
                this.getRequest("/diagnosis/remark/"+row.id).then(res=>{
                    this.form.desc = res;
                })
            },
            initD() {
                this.loading1 = true;
                if (sessionStorage.getItem("notprocess")) {
                    let res = JSON.parse(sessionStorage.getItem("notprocess"));
                    for (let i in res) {
                        if (res[i].status === 0) {
                            this.tableData.push(res[i])
                        }
                        if (res[i].status === 1) {
                            this.processed.push(res[i])
                        }
                        if (res[i].status === 2) {
                            this.ignored.push(res[i])
                        }
                    }
                    this.loading1 = false;
                } else {
                    this.getRequest("/diagnosis/").then(res => {
                        sessionStorage.setItem("notprocess", JSON.stringify(res));
                        for (let i in res) {
                            if (res[i].status === 0) {
                                this.tableData.push(res[i])
                            }
                            if (res[i].status === 1) {
                                this.processed.push(res[i])
                            }
                            if (res[i].status === 2) {
                                this.ignored.push(res[i])
                            }
                        }
                        this.loading1 = false;
                    });
                }
            },
            handleSelection1(val) {
                this.ids=[];
                for (let i in val) {
                    this.ids.push(val[i].id);
                }
            },
            selectedIngore(){
                this.$confirm('此操作将忽略这些故障, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.doBtn = true;
                    sessionStorage.setItem("notprocess","");
                    this.tableData=[];
                    this.postRequest("/diagnosis/check/ignore/?ids="+this.ids).then(res=>{
                        if (res) {
                            this.initD();
                        }
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消操作'
                    });
                });
            },
            selectedDelete(){
                this.$confirm('此操作将忽略这些故障, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    sessionStorage.setItem("notprocess","");
                    this.tableData=[];
                    this.processed=[];
                    this.ignored=[];
                    this.deleteRequest("/diagnosis/check/delete/?ids="+this.ids).then(res=>{
                        if (res) {
                            this.initD();
                        }
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消操作'
                    });
                });
            },
            selectedProcess(){
                this.form.desc='';
                this.idsOne=[];
                this.selectedRemark=true;
                this.idsOne= this.ids;
            },
            doSelectedRe(){
                this.selectedRemark = false;
                this.$confirm('此操作将批量添加备注, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    sessionStorage.setItem("notprocess","");
                    this.tableData=[];
                    this.putRequest("/diagnosis/check/remark/?idsOne="+ this.idsOne+"&desc="+this.form.desc).then(res=>{
                        if (res) {
                            this.initD();
                            this.selectedRemark=false;
                        }else {
                            this.initD();
                            this.selectedRemark=false;
                        }
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消操作'
                    });
                });
            },
            handleSelection2(val) {
                this.ids=[];
                for (let i in val) {
                    this.ids.push(val[i].id);
                }
            },
            handleSelection3(val) {
                this.ids=[];
                for (let i in val) {
                    this.ids.push(val[i].id);
                }
            },
        },
        mounted() {
            this.initD();
        }
    }
</script>

<style scoped>

    .st-square-warning {
        background-color: #ebb134;
    }
    .st-square-deepred {
        background-color: #eb0200;
    }

    .st-square-ignorance {
        background-color: #9d9e9c;
    }

    .st-square-success {
        background-color: #5deb24;
    }

    .st-square {
        cursor: pointer;
        margin-right: 6px;
        width: 9px;
        height: 9px;
        display: inline-block;
    }

    .demo-table-expand {
        font-size: 0;
    }

    .demo-table-expand label {
        width: 90px;
        color: #99a9bf;
    }

    .demo-table-expand .el-form-item {
        margin-right: 0;
        margin-bottom: 0;
        width: 100%;
    }
</style>
