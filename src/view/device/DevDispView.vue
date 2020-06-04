<template>
    <div style="width: 100%;height: 100%">
        <el-row>
            <el-col :span="24">
                <span style="margin-right: 10px;">选择设备</span>
                <el-select @change="getIp" style="width: 300px" size="small" filterable v-model="value"
                           placeholder="请选择">
                    <el-option
                            v-for="item in devdata"
                            :key="item.ip"
                            :label="item.ip+'-'+item.name"
                            :value="item.ip">
                        <span style="float: left">{{ item.ip }}</span>
                        <span style="float: right; color: #8492a6; font-size: 13px">{{ item.name }}</span>
                    </el-option>
                </el-select>
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="24">
                <CpuInfoWithLongTime :data="ip" id="cputime"/>
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="24">
                <MemInfoWithLongTime :data="ip" id="memtime"/>
            </el-col>
        </el-row>
        <el-divider><i class="el-icon-data-analysis"></i></el-divider>

    </div>
</template>

<script>
    import CpuInfoWithLongTime from "../../components/dev/CpuInfoWithLongTime";
    import MemInfoWithLongTime from "../../components/dev/MemInfoWithLongTime";


    export default {
        name: "DevDispView",
        components: { MemInfoWithLongTime, CpuInfoWithLongTime},
        data() {
            return {
                ip: '',
                devdata: [],
                value: '',
            }
        },
        mounted() {
            this.getSelectList();
        },
        methods: {
            getIp(val) {
                this.ip = val;
            },
            getSelectList() {
                this.getRequest("/device/select").then(res => {
                    this.value = res[0].ip;
                    this.ip = res[0].ip;
                    this.devdata = res;
                })
            }
        }
    }
</script>

<style scoped>

</style>
