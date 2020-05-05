<template>
    <div style="width: 100%;height: 100%">
        <el-row>
            <el-col :span="24">
                <span style="margin-right: 10px;">选择设备查看设备详细信息</span>
                <el-select style="width: 300px" size="small" v-model="value" placeholder="请选择">
                    <el-option
                            v-for="item in devdata"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                        <span style="float: left">{{ item.label }}</span>
                        <span style="float: right; color: #8492a6; font-size: 13px">{{ item.value }}</span>
                    </el-option>
                </el-select>
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="24">
                <CpuInfoWithLongTime id="cputime"/>
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="24">
                <MemInfoWithLongTime id="memtime"/>
            </el-col>
        </el-row>
        <el-divider><i class="el-icon-data-analysis"></i></el-divider>
        <el-row>
            <el-col :span="24">
                请选择接口查看展示流量
                <el-select size="small" v-model="value" filterable placeholder="请选择接口查看展示流量">
                    <el-option
                            v-for="item in inter"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                    </el-option>
                </el-select>
                是否仅查看设备整体流量情况
                <el-switch
                        v-model="IsAllInter"
                        active-color="#13ce66"
                        inactive-color="#ff4949">
                </el-switch>
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="24">
                <FlowInfoWithLongTime id="flowTime"/>
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="24">
               <FlowDataAnalysis id="dataAnalysis" />
            </el-col>
        </el-row>
    </div>
</template>

<script>
    import CpuInfoWithLongTime from "../../components/dev/CpuInfoWithLongTime";
    import MemInfoWithLongTime from "../../components/dev/MemInfoWithLongTime";
    import FlowInfoWithLongTime from "../../components/dev/FlowInfoWithLongTime";
    import FlowDataAnalysis from "../../components/dev/FlowDataAnalysis";

    export default {
        name: "DevDispView",
        components: {FlowDataAnalysis, FlowInfoWithLongTime, MemInfoWithLongTime, CpuInfoWithLongTime},
        data() {
            return {
                IsAllInter: false,
                inter: [{
                    value: 'F0/0',
                    label: 'F0/0'
                }],
                devdata: [{
                    value: '172.17.137.115',
                    label: '测试路由器'
                }, {
                    value: '172.17.136.86',
                    label: '应用服务器'
                }, {
                    value: '172.17.137.60',
                    label: '测试交换机'
                }, {
                    value: '172.17.137.61',
                    label: '测试交换机'
                }, {
                    value: '172.17.137.126',
                    label: '长庚楼汇聚交换机'
                }, {
                    value: '172.17.137.22',
                    label: '无'
                }],
                value: ''
            }
        }
    }
</script>

<style scoped>

</style>
