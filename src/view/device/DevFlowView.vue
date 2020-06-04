<template>
    <div>
        <div style="border-radius: 5px;border: 1px solid #f0f0f0;line-height: 50px;text-align: center">
            <el-row>
                <el-col :span="8">
                    <span style="margin-right: 10px;">设备选择</span>
                    <el-select @change="getIp" style="width: 300px" size="small" filterable v-model="value"
                               placeholder="请选择">
                        <el-option
                                v-for="item in data"
                                :key="item.ip"
                                :label="item.ip+'-'+item.name"
                                :value="item.ip">
                            <span style="float: left">{{ item.ip }}</span>
                            <span style="float: right; color: #8492a6; font-size: 13px">{{ item.name }}</span>
                        </el-option>
                    </el-select>
                </el-col>
                <el-col :span="6">
                    接口选择
                    <el-select size="small" :disabled="OnDisable" v-model="intervalue" @change="ifFlow" filterable
                               placeholder="请选择接口查看展示流量">
                        <el-option
                                v-for="item in inter"
                                :key="item.ifDescr"
                                :label="item.ifDescr"
                                :value="item.ifDescr">
                        </el-option>
                    </el-select>
                </el-col>
                <el-col :span="3">
                    开启整体统计
                    <el-switch
                            @change="OnTotal"
                            v-model="IsAllInter"
                            active-color="#13ce66"
                            inactive-color="#ff4949">
                    </el-switch>
                </el-col>
                <el-col :span="2">
                    <el-button type="primary" :disabled="disableHigh" @click="OnHigh" size="small">高级功能</el-button>
                </el-col>
            </el-row>
            <el-row v-show="isHigh">
                <el-col :span="4">
                    过滤vlan接口
                    <el-switch
                            @change="filterV"
                            v-model="filterVlan"
                            active-color="#13ce66"
                            inactive-color="#ff4949">
                    </el-switch>
                </el-col>
                <el-col :span="4">
                    过滤无数据接口
                    <el-switch
                            @change="filterND"
                            v-model="filterNodata"
                            active-color="#13ce66"
                            inactive-color="#ff4949">
                    </el-switch>
                </el-col>
            </el-row>
        </div>
        <el-row>
            <el-col :span="12">
                <FlowInfoWithLongTime :data="flow" id="flowTime"/>
            </el-col>
            <el-col :span="12">
                <FlowDataAnalysis :data="flow" id="dataAnalysis"/>
            </el-col>
        </el-row>
        <el-divider><i class="el-icon-data-analysis"></i></el-divider>
        <el-row>
            <el-col :span="12">
                <FlowDataAnalysisByLoss :data="flow" id="flowTimeByLoss"/>
            </el-col>
            <el-col :span="12">
                <FlowDataAnalysisByError :data="flow" id="dataAnalysisByLoss"/>
            </el-col>
        </el-row>
    </div>
</template>

<script>
    import FlowInfoWithLongTime from "../../components/dev/FlowInfoWithLongTime";
    import FlowDataAnalysis from "../../components/dev/FlowDataAnalysis";
    import FlowDataAnalysisByLoss from "../../components/dev/FlowDataAnalysisByLoss";
    import FlowDataAnalysisByError from "../../components/dev/FlowDataAnalysisByError";

    export default {
        name: "DevFlowView",
        components: {FlowDataAnalysis, FlowInfoWithLongTime, FlowDataAnalysisByLoss, FlowDataAnalysisByError},
        data() {
            return {
                isHigh: false,
                disableHigh: false,
                filterVlan: false,
                OnDisable: false,
                filterNodata: false,
                ip: '',
                interface: '',
                data: [],
                flow: [],
                value: '',
                IsAllInter: false,
                inter: [],
                intervalue: '',
            }
        },
        mounted() {
            this.getSelect()
            this.getData();
        },
        methods: {

            OnHigh() {
                this.isHigh = !this.isHigh;
                if (!this.isHigh) {
                    this.filterVlan = false;
                    this.OnDisable = false;
                }
            },
            getIp(val) {
                if (this.IsAllInter) {
                    this.getDevTotal(val);
                } else {
                    this.getInterface(val);
                    this.ip = val;
                }
            },
            ifFlow(val) {
                this.getInterData(this.ip, val);
            },
            OnTotal(val) {
                if (val) {
                    this.isHigh = false;
                    this.OnDisable = true;
                    this.disableHigh = true;
                    this.getDevTotal(this.ip);
                } else {
                    this.OnDisable = false;
                    this.disableHigh = false;
                    this.getSelect();
                }
            },
            filterV(val) {
                if (val) {
                    this.getFilterVlan(this.ip);
                } else {
                    this.getInterface(this.ip);
                }
            },
            filterND(val) {
                if (val) {
                    this.getFilterNoData(this.ip)
                } else {
                    this.getInterface(this.ip);
                }
            },
            getSelect() {
                this.getRequest("/device/select").then(res => {
                    this.value = res[0].ip;
                    this.ip = res[0].ip;
                    this.data = res;
                    this.getInterface(this.value = res[0].ip);
                })
            },
            getInterface(ip) {
                this.getRequest("/device/getinterface?ip=" + ip).then(res => {
                    this.intervalue = res[0].ifDescr;
                    this.getInterData(ip, this.intervalue);
                    this.inter = res;
                })
            },
            getInterData(ip, inter) {
                this.getRequest("/device/getinterflow?ip=" + ip + "&interName=" + inter).then(res => {
                    this.flow = res;
                })
            },
            getDevTotal(ip) {
                this.getRequest("/device/getAllInterflow?ip=" + ip).then(res => {
                    this.flow = res
                })
            },
            getFilterVlan(ip) {
                this.getRequest("/device/filtervlan?ip=" + ip).then(res => {
                    this.intervalue = res[0].ifDescr;
                    this.getInterData(ip, this.intervalue);
                    this.inter = res;
                })
            },
            getFilterNoData(ip) {
                this.getRequest("/device/filteremptydata?ip=" + ip).then(res => {
                    this.intervalue = res[0].ifDescr;
                    this.getInterData(ip, this.intervalue);
                    this.inter = res;
                })
            }
        }

    }
</script>

<style>

</style>
