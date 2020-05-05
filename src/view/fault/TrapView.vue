<template>
    <div>
        <div>
            <span style="float: left;margin-top: 3px;margin-right: 30px;font-family: 微软雅黑;font-size: 25px;display: block">TRAP信息</span>
            <el-date-picker
                    size="small"
                    v-model="multiDate"
                    type="datetimerange"
                    align="right"
                    start-placeholder="开始日期"
                    end-placeholder="结束日期"
                    @change="doSub"
                    :default-time="['12:00:00', '08:00:00']">
            </el-date-picker>
        </div>
        <el-table
                ref="multipleTable"
                height="500"
                size="small"
                :data="trapData.filter(data => !search || data.zhpoint.toLowerCase().includes(search.toLowerCase()))"
                tooltip-effect="dark"
                style="width: 100%"
                @selection-change="handleChange">
            <el-table-column
                    type="selection"
                    width="55">
            </el-table-column>
            <el-table-column
                    label="节点"
                    prop="ip"
            width="120">
            </el-table-column>
            <el-table-column
                    label="监测点"
                    prop="zhpoint">
            </el-table-column>
            <el-table-column
                    label="团体名"
                    prop="community">
            </el-table-column>
            <el-table-column
                    label="版本"
                    prop="version">
            </el-table-column>
            <el-table-column
                    label="告警时间"
                    prop="time">
            </el-table-column>
            <el-table-column
                    prop="value"
                    label="详细"
                    type="expand"
                    width="120">
                <template slot-scope="props">
                    <el-form size="small" label-position="left" inline class="demo-table-expand">
                        <el-form-item  label="详细信息">
                            <span>{{ props.row.value }}</span>
                        </el-form-item>
                    </el-form>
                </template>
            </el-table-column>
            <el-table-column
                    align="right">
                <template slot="header" slot-scope="scope">
                    <el-input
                            v-model="search"
                            size="mini"
                            placeholder="输入监测点关键字搜索"/>
                </template>
                <template slot-scope="scope">
                    <el-button
                            size="mini"
                            @click="handleEdit(scope.$index, scope.row)">处理
                    </el-button>
                    <el-button
                            size="mini"
                            type="danger"
                            @click="handleDelete(scope.$index, scope.row)">删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>
        <div style="width: 100%;margin-top: 10px;display: flex;align-items: flex-start">
            <el-tag type="success" style="margin-right: 10px;">共{{trapData.length}}条数据</el-tag>
            <el-button size="small" type="success">处理选中</el-button>
            <el-button size="small" type="danger">删除选中</el-button>
            <el-button size="small" type="success">导出所有</el-button>
        </div>
    </div>
</template>

<script>
    export default {
        name: "TrapView",
        data() {
            return {
                multiDate:'',
                trapData: [],
                search: '',
                multipleSelection: [],
            }
        },
        mounted(){
          this.initTrap();
        },
        methods: {
            doSub(val){

            },
            initTrap(){
                if (sessionStorage.getItem("trap")){
                    let res = JSON.parse(sessionStorage.getItem("trap"));
                    for (let i in res) {
                        if (res[i].status === 0) {
                            this.trapData.push(res[i])
                        }
                    }
                } else {
                    this.getRequest("/trap/").then(res => {
                        console.log(res);
                        sessionStorage.setItem("trap",JSON.stringify(res));
                        for (let i in res) {
                            if (res[i].status === 0) {
                                this.trapData.push(res[i])
                            }
                        }
                    });
                }
            },
            handleEdit(index, row) {
                console.log(index, row);
            },
            handleDelete(index, row) {
                console.log(index, row);
            },
            toggle(rows) {
                if (rows) {
                    rows.forEach(row => {
                        this.$refs.multipleTable.toggleRowSelection(row);
                    });
                } else {
                    this.$refs.multipleTable.clearSelection();
                }
            },
            handleChange(val) {
                this.multipleSelection = val;
            },
        },
    }
</script>

<style>
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
