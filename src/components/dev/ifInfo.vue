<template>
    <div :id="id" >
        <el-table
                size="small"
                :data="ifbase"
                border
                height="200"
                style="width: 100%"
                stripe>
            <el-table-column
                    prop="ifDescr"
                    label="名称"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="ifOperStatus"
                    label="操作状态(线路状态)">
            </el-table-column>
            <el-table-column
                    prop="ifAdminStatus"
                    label="管理状态">
            </el-table-column>
            <el-table-column
                    prop="ifSpeed"
                    label="带宽(字节)">
            </el-table-column>
            <el-table-column
                    prop="ifMtu"
                    label="MTU">
            </el-table-column>
        </el-table>
    </div>
</template>

<script>
    export default {
        name: "ifInfo",
        data(){
          return{
              ifbase:[],
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
                    this.ifbase = newV
                },
                deep:true
            },
        }
    }
</script>

<style scoped>

</style>
