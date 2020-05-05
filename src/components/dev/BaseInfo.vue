<template>
    <div>
        <div slot="header" class="clearfix">
            <span>基础信息</span>
        </div>
        <div class="text item" style="margin-bottom: 20px;font-size: 14px">
            <table>
                <tr>
                    <td>设备IP：
                        <el-tag size="medium">{{BaseInfo.ip}}</el-tag>
                    </td>
                </tr>
                <tr>
                    <td>设备系统运行时长：
                        <el-tag size="medium">{{BaseInfo.sysUptime}}</el-tag>
                    </td>
                </tr>
                <tr>
                    <td>设备系统联系人：
                        <el-tag size="medium">{{BaseInfo.sysContact}}</el-tag>
                    </td>
                </tr>
                <tr>
                    <td>设备系统机器名：
                        <el-tag size="medium">{{BaseInfo.sysName}}</el-tag>
                    </td>
                </tr>
                <tr>
                    <td style="display: flex;align-items: center">设备基础信息：
                        <el-tag :title="BaseInfo.sysBaseInfo"
                                style="width: 180px;overflow: hidden; text-overflow: ellipsis; white-space:nowrap;"
                                size="medium">{{BaseInfo.sysBaseInfo}}
                        </el-tag>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</template>

<script>
    export default {
        name: "BaseInfo",
        data() {
            return {
                BaseInfo: '',
            }
        },
        props: {
            data: Object
        },
        methods: {
            initBase() {

            }
        },
        mounted() {
            this.initBase();
        },
        watch: {
            data: {
                handler(newV, oldV) {
                    this.BaseInfo = newV
                },
                deep: true
            },
        }
    }
</script>

<style>
</style>
