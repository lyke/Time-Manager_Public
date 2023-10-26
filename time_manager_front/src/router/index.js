import { createRouter, createWebHistory } from 'vue-router'
import LoginView from '../views/LoginView'
import TeamsView from '../views/TeamsView'
import DashboardView from '../views/DashboardView'

const routes = [
  {
    path: '/',
    name: 'login',
    component: LoginView
  },
  {
    path: '/teams',
    name: 'teams',
    component: TeamsView
  },
  {
    path: '/dashboard',
    name: 'dashboard',
    component: DashboardView
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
