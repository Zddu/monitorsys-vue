<template>
    <div class="item">
        <el-scrollbar class="default-scrollbar" wrap-class="default-scrollbar__wrap" view-class="p20-scrollbar__view"
                      :native="false">
            <div style="overflow-y: auto;height: 100%; width:100%;overflow-x: hidden;">
                <ul class="Glog">
                    <li style="cursor: pointer;margin-bottom: 10px;" v-for="(item) in gLog">
                        <i class="el-icon-bell" style="margin-left: 10px;color: #ff3003"></i>
                        <span class="testinfo">节点:{{item.ip}}</span>
                        <span class="testinfo">故障级别: <span :class="item.rank==='危险'? orangec:redc">{{item.rank}}</span></span>
                        <span class="testtime" :title="item.time">{{item.time}}</span>
                    </li>
                </ul>
            </div>
        </el-scrollbar>
    </div>
</template>

<script>
    export default {
        name: "NotProcessInfo",
        data() {
            return {
                gLog: [],
                orangec:'orange',
                redc:'red'
            }
        },
        mounted(){
            this.getInfo()
        },
        methods:{
          getInfo(){
              this.getRequest("/home/getNewDiagnosis").then(res=>{
                 this.gLog = res;
              })
          }
        }
    }
</script>

<style>
    .item {
        margin-top: 10px;
        position: relative;
        overflow: hidden;
        width: 100%;
        height: 180px;
        border: 1px solid #d0dce2;
        padding: 5px;
        box-sizing: border-box;
        border-radius: 5px;
    }

    .Glog {
        padding: 0;
        margin: 0;
        list-style: none;
        line-height: 0;
    }

    .testinfo {
        max-width: 50%;
        overflow: hidden;
        white-space: nowrap;
        margin-left: 15px;
    }
    .orange{
        color: orange;
    }
    .red{
        color: red;
    }
    .testtime {
        position: absolute;
        right: 0;
        top: 0;
        max-width: 25%;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
        display: block;
    }

    .Glog li {
        position: relative;
        height: 30px;
        line-height: 30px !important;
        border-bottom: 1px solid #d0dce2;
    }

    .Glog img {
        float: left;
        width: 20px;
        height: 20px;
        vertical-align: middle;
        margin-right: 10px;
        margin-top: 3px;
    }
</style>
