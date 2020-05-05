<template>
    <div :id="id" >
        <el-table
                size="small"
                :data="ifFlow"
                border
                height="200"
                style="width: 100%"
                stripe>
            <el-table-column
                    prop="interDescr"
                    label="端口描述">
            </el-table-column>
            <el-table-column
                    sortable
                    prop="inFlow"
                    label="接收流量kb/s">
            </el-table-column>
            <el-table-column
                    sortable
                    prop="outFlow"
                    label="发送流量kb/s">
            </el-table-column>
            <el-table-column
                    sortable
                    prop="inRate"
                    label="接收占比率(%)">
            </el-table-column>
            <el-table-column
                    sortable
                    prop="outRate"
                    label="发送占比率(%)">
            </el-table-column>
            <el-table-column
                    sortable
                    prop="inLoss"
                    label="接收丢包率(%)">
            </el-table-column>
            <el-table-column
                    sortable
                    prop="outLoss"
                    label="发送丢包率(%)">
            </el-table-column>
            <el-table-column
                    sortable
                    prop="inErrorRate"
                    label="接收错误率(%)">
            </el-table-column>
            <el-table-column
                    sortable
                    prop="outErrorRate"
                    label="发送错误率(%)">
            </el-table-column>

        </el-table>
    </div>
</template>

<script>
    export default {
        name: "ifFlow",
        data(){
            return{
                ifFlow:[],
            }
        },
        props: {
            id: {
                type: String
            },
            ip:{
                type:String
            },
            width: {
                type: String,
                default: "100%"
            },
            height: {
                type: String,
                default: "200px"
            },
            data: Array,
        },
        computed: {
            style() {
                return {
                    height: this.height,
                    width: this.width
                }
            }
        },
        watch:{
            data:{
                handler (newV, oldV) {
                    this.ifFlow = newV;
                },
                deep:true
            },
        }
    }
</script>

<style scoped>

</style>
