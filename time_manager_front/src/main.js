import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import axios from 'axios';
import notifications from '@kyvg/vue3-notification'

axios.defaults.baseURL = 'https://time-manager-epitech.gigalixirapp.com/api';

require('@/assets/main.scss');

createApp(App)
    .use(router)
    .use(notifications)
    .mount('#app')
