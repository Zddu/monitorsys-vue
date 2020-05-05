<template>
    <div style="height: 100%;">
        <el-row :gutter="10">
            <el-col :span="8">
                <div style="height: 100%">
                    <el-card shadow="hover" style="height: 474px;">
                        <span style="margin-right: 10px;">选择需要监测的设备</span>
                        <el-input
                                style="margin: 10px 0"
                                size="small"
                                placeholder="输入关键字进行过滤"
                                v-model="filterText">
                        </el-input>
                        <div style="border: 1px solid #d4d4d4;border-radius: 3px;width: 340px;height: 360px;">
                            <el-scrollbar class="default-scrollbar" wrap-class="default-scrollbar__wrap"
                                          view-class="p20-scrollbar__view" :native="false">
                                <el-tree
                                        show-checkbox
                                        class="filter-tree"
                                        :data="data"
                                        :props="defaultProps"
                                        default-expand-all
                                        :filter-node-method="filterNode"
                                        ref="tree">
                                </el-tree>
                            </el-scrollbar>
                        </div>
                    </el-card>
                </div>
            </el-col>
            <el-col :span="16">
                <div style="margin-left: 10px;">
                    <el-card shadow="hover" style="height: 474px;width: 100%;">
                        <span style="margin-right: 10px;">添加监测点</span>
                        <el-transfer
                                style="margin-top: 10px;"
                                :titles="['可选监测点', '已选监测点']"
                                v-model="tanfvalue"
                                :data="trandata">
                        </el-transfer>
                    </el-card>
                </div>
            </el-col>
        </el-row>
        <el-row style="margin-top: 10px;">
            <el-col :span="24">
                <el-card shadow="hover" style="width:100%;">
                    <span>设置监控频率</span>
                    <div>
                        对所选设备的监测点每
                        <el-input-number :min=2 size="mini" v-model="hourData"></el-input-number>
                        小时的频率轮询监测，监测间隔至少有2小时。

                    </div>
                </el-card>
            </el-col>
            <el-col :span="24">
                <el-card shadow="hover" style="width:100%;">
                    <el-button type="primary" size="small">提交设置</el-button>
                </el-card>
            </el-col>
        </el-row>
    </div>
</template>

<script>
    export default {
        name: "RuleSet",
        watch: {
            filterText(val) {
                this.$refs.tree.filter(val);
            }
        },

        methods: {
            filterNode(value, data) {
                if (!value) return true;
                return data.label.indexOf(value) !== -1;
            }
        },

        data() {
            return {
                hourData: '',
                minData: '',
                filterText: '',
                data: [{
                    id: 1,
                    label: '服务器',
                    children: [{
                        id: 4,
                        label: '172.17.137.85',
                    }, {
                        id: 5,
                        label: '172.17.137.86',
                    }]
                }, {
                    id: 2,
                    label: '网络设备',
                    children: [{
                        id: 5,
                        label: '172.17.137.115'
                    }, {
                        id: 5,
                        label: '172.17.137.115'
                    }, {
                        id: 5,
                        label: '172.17.137.115'
                    }, {
                        id: 5,
                        label: '172.17.137.115'
                    }, {
                        id: 5,
                        label: '172.17.137.115'
                    }, {
                        id: 5,
                        label: '172.17.137.115'
                    }, {
                        id: 6,
                        label: '172.17.136.23'
                    }, {
                        id: 6,
                        label: '172.17.136.23'
                    }, {
                        id: 6,
                        label: '172.17.136.23'
                    }, {
                        id: 6,
                        label: '172.17.136.23'
                    }, {
                        id: 6,
                        label: '172.17.136.23'
                    }, {
                        id: 6,
                        label: '172.17.136.23'
                    }, {
                        id: 6,
                        label: '172.17.136.23'
                    }, {
                        id: 6,
                        label: '172.17.136.23'
                    }, {
                        id: 6,
                        label: '172.17.136.23'
                    }]
                }],
                defaultProps: {
                    children: 'children',
                    label: 'label'
                },
                trandata: [
                    {
                        key: 'SNMP连通性',
                        label: 'SNMP连通性'
                    }, {
                        key: 'ping连通性',
                        label: 'ping连通性'
                    }, {
                        key: '接口状态',
                        label: '接口状态'
                    }, {
                        key: 'CPU使用率',
                        label: 'CPU使用率'
                    }, {
                        key: '内存使用率',
                        label: '内存使用率'
                    }
                ],
                tanfvalue: []
            };
        }
    }
</script>

<style>
    .el-transfer-panel__body {
        height: 363px !important;
    }
</style>
