import Vue from 'vue'
import Router from 'vue-router'
import Home from './view/Home'
import DeviceConfig from "./view/device/DeviceConfig";
import Login from "./view/login/Login";
import HitchView from "./view/fault/HitchView";
import TrapView from "./view/fault/TrapView";
import HitchRequire from "./view/fault/HitchRequire";
import FailureAll from "./view/fault/FailureAll";
import RuleSet from "./view/fault/RuleSet";
import DevDispView from "./view/device/DevDispView";
import DevFormView from "./view/device/DevFormView";
Vue.use(Router);
export default new Router({
    routes: [
        {
            path: '/home',
            name: 'Home',
            component: Home,
            hidden:true,
            children:[
                {
                    path: '/deviceManage',
                    name: '设备管理',
                    component: DeviceConfig,
                    hidden:true,
                },{
                    path: '/faultManage',
                    name: '故障视图',
                    component: HitchView,
                    hidden:true,
                },{
                    path: '/hitchRequire',
                    name: '故障查询',
                    component: HitchRequire,
                    hidden:true,
                },{
                    path: '/trap',
                    name: 'TRAP日志',
                    component: TrapView,
                    hidden:true,
                },{
                    path: '/failureAll',
                    name: '故障总览',
                    component: FailureAll,
                    hidden:true,
                },{
                    path: '/ruleset',
                    name: '规则设置',
                    component: RuleSet,
                    hidden:true,
                },{
                    path: '/devDis',
                    name: '视图展示',
                    component: DevDispView,
                    hidden:true,
                },{
                    path: '/devForm',
                    name: '图表展示',
                    component: DevFormView,
                    hidden:true,
                }
            ]
        },{
            path: '/',
            name: 'Login',
            component: Login,
            hidden:true,
        }
    ]
})
