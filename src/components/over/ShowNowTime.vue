<template>
    <div>
        <div class="ShowTime">
            <div class="time">{{time}}</div>
            <div class="wd">
                <span>{{week}}</span>
                <span>{{date}}</span>
                <span>{{lunar}}</span>
            </div>

        </div>
    </div>
</template>

<script>
    import method from '../../utils/navCal'
    export default {
        name: "ShowNowTime",
        data() {
            return {
                date: '',
                time: '',
                week: '',
                lunar: '',
            }
        },
        mounted() {
            this.currentTime()
        },
        methods: {
            getTime: function () {
                let yy = new Date().getFullYear();
                let mm = new Date().getMonth() + 1;
                let dd = new Date().getDate();
                let hh = new Date().getHours();
                let mf = new Date().getMinutes() < 10 ? '0' + new Date().getMinutes() : new Date().getMinutes();
                let ss = new Date().getSeconds() < 10 ? '0' + new Date().getSeconds() : new Date().getSeconds();
                this.date = yy + '-' + mm + '-' + dd;
                this.time = hh + ':' + mf + ':' + ss;
                let week = new Date(new Date()).getDay();
                let weeks = ["日", "一", "二", "三", "四", "五", "六"];
                this.week = "星期" + weeks[week];
                this.lunar = method.toLunar(yy,mm,dd)
            },
            currentTime() {
                setInterval(this.getTime, 500)
            },
        }
    }
</script>

<style>
    .ShowTime {
        background: #f5f7fa;
        box-sizing: border-box;
        display: flex;
        align-items: center;
        width: 100%;
        height: 90px;
        padding: 0 0 0 15px;
    }

    .ShowTime .time {
        font-size: 60px;
        line-height: 85px;
    }

    .ShowTime .wd {
        height: 100%;
        width: 100%;
        position: relative;
    }

    .ShowTime .wd span:nth-child(1) {
        position: absolute;
        top: 15px;
        font-size: 28px;
        left: 5px;
    }

    .ShowTime .wd span:nth-child(2) {
        position: absolute;
        top: 50px;
        font-size: 18px;
        left: 6px;
    }
    @media screen and (max-width: 1450px) {
        .ShowTime .wd span:nth-child(3) {
           display: none;
        }
    }

    .ShowTime .wd span:nth-child(3) {
        position: absolute;
        left: 100px;
        top: 18px;
        font-size: 18px;
        width: 30px;
    }
</style>
