import Vue from 'vue'
import Vuex from 'vuex'
import {getRequest} from "../utils/api";

Vue.use(Vuex);
const store = new Vuex.Store({
    state: {
        cpuData:[],
    },
    mutations: {
        initCpuData(state, data){
            state.cpuData = data
        }
    },
    actions: {

    }
})
export default store;
