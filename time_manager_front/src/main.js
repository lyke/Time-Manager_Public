import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import axios from 'axios';
import notifications from '@kyvg/vue3-notification'

var token = "";
try {
    token = localStorage.getItem("token");
    axios.defaults.headers.common = {'Authorization': `Bearer ${token}`}
} catch {
    router.push({name: "login"});
}

axios.defaults.baseURL = 'http://localhost:4000/api';

require('@/assets/main.scss');

createApp(App)
    .use(router)
    .use(notifications)
    .mount('#app')
