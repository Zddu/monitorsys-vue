<template>
    <div>
        <template>
            <el-table
                    :data="prediction"
                    border
                    size="small"
                    style="width: 100%">
                <el-table-column
                        fixed
                        type="index"
                        width="50">
                </el-table-column>
                <el-table-column
                        prop="date"
                        label="序号"
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="name"
                        label="姓名"
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="address"
                        label="地址">
                </el-table-column>
            </el-table>
        </template>
    </div>
</template>

<script>
    export default {
        name: "FormFlowAnalysis",
        data(){
            return{
                prediction:[],
            }
        }
    }
</script>

