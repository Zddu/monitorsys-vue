import Vue from 'vue'
import Router from 'vue-router'
import Home from './view/Home'
import Login from "./view/login/Login";
import HitchView from "./view/fault/HitchView";
import TrapView from "./view/fault/TrapView";
import HitchRequire from "./view/fault/HitchRequire";
import FailureAll from "./view/fault/FailureAll";
import RuleSet from "./view/fault/RuleSet";
import DevDispView from "./view/device/DevDispView";
import DevFlowView from "./view/device/DevFlowView";
import FailureAnalysis from "./view/fault/FailureAnalysis";
import DevBaseInfo from "./view/device/DevBaseInfo";
import FlowClassify from "./view/flow/FlowClassify";
import DataProcessing from "./view/flow/DataProcessing";
import ModelTrain from "./view/flow/ModelTrain";
import FileClassify from "./view/flow/FileClassify";
import TopoMain from "./view/topology/TopoMain";
import DeviceInitConfig from "./view/init/DeviceInitConfig";
import DeviceConfig from "./view/device/DeviceConfig";
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
                    name: '硬件管理',
                    component: DevDispView,
                    hidden:true,
                },{
                    path: '/topo',
                    name: '拓扑展示',
                    component: TopoMain,
                    hidden:true,
                },{
                    path: '/devBase',
                    name: '基础信息',
                    component: DevBaseInfo,
                    hidden:true,
                },{
                    path: '/devForm',
                    name: '流量展示',
                    component: DevFlowView,
                    hidden:true,
                },{
                    path: '/failAnalysis',
                    name: '故障分析',
                    component: FailureAnalysis,
                    hidden:true,
                },{
                    path: '/flowClassify',
                    name: '自动分类',
                    component: FlowClassify,
                    hidden:true,
                },{
                    path: '/dataProcessing',
                    name: '数据加工',
                    component: DataProcessing,
                    hidden:true,
                },{
                    path: '/modelTrain',
                    name: '模型训练',
                    component: ModelTrain,
                    hidden:true,
                },{
                    path: '/fileClassify',
                    name: '文件分类',
                    component: FileClassify,
                    hidden:true,
                }
            ]
        },
        {
            path: '/',
            name: 'Login',
            component: Login,
            hidden:true,
        },
        {
            path: '/config',
            name: '设备配置',
            component: DeviceInitConfig,
        }
    ]
})
