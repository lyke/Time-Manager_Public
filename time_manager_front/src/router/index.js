import { createRouter, createWebHistory } from 'vue-router'
import LoginView from '../views/LoginView'
import RegisterView from '../views/RegisterView'
import TeamsView from '../views/TeamsView'
import DashboardView from '../views/DashboardView'

const routes = [
  {
    path: '/',
    name: 'login',
    component: LoginView
  },
  {
    path: '/register',
    name: 'register',
    component: RegisterView
  },
  {
    path: '/teams',
    name: 'teams',
    component: TeamsView
  },
  {
    path: '/dashboard/:user_id',
    name: 'dashboard',
    component: DashboardView,
    props: true
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
