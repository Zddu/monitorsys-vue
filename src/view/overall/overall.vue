<template>
    <div style="width: 100%">
        <el-row style="width: 100%" type="flex" class="row-bg" justify="space-around">
            <el-col :span="8">
                <AllNetworkInfo  id="allinfo" />
                <AlarmInfo id="alarm" />
                <NotProcessInfo/>
            </el-col>
            <el-col :span="9">
                <DeviceTotal id="device"/>
                <PointTotal id="pointT"/>
            </el-col>
            <el-col :span="7">
                <ShowNowTime />
                <ShowLocalCpu id="localCpu" />
                <ShowLocalMem id="localMem" />
            </el-col>
        </el-row>
    </div>
</template>

<script>
    import AllNetworkInfo from "../../components/over/AllNetworkInfo";
    import AlarmInfo from "../../components/over/alarmInfo";
    import NotProcessInfo from "../../components/over/NotProcessInfo";
    import DeviceTotal from "../../components/over/DeviceTotal";
    import PointTotal from "../../components/over/PointTotal";
    import ShowNowTime from "../../components/over/ShowNowTime";
    import ShowLocalCpu from "../../components/over/ShowLocalCpu";
    import ShowLocalMem from "../../components/over/ShowLocalMem";
    export default {
        name: "overall",
        components: {
            ShowLocalMem,
            ShowLocalCpu, ShowNowTime, PointTotal, DeviceTotal, NotProcessInfo, AlarmInfo, AllNetworkInfo},
        data() {
            return {
            }
        },
        methods: {
        },
        mounted() {

        },
    }
</script>

<style scoped>
    body {
        font-family: 微软雅黑, Arial;
        font-size: 12px;
        padding: 0px;
        font-weight: 400;
    }
    #allinfo{

    }
    a {
        text-decoration: none;
        font-size: 12px;
    }
</style>
