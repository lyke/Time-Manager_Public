import { createRouter, createWebHistory } from 'vue-router'
import LoginView from '../views/LoginView'
import RegisterView from '../views/RegisterView'
import TeamsView from '../views/TeamsView'
import DashboardView from '../views/DashboardView'
import ParameterView from '../views/ParameterView'
import AdministrationView from '../views/AdministrationView'

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
    path: "/dashboard",
    name: 'dashboard',
    component: DashboardView,
    props: true
  },
  {
    path: '/parameter',
    name: 'parameter',
    component: ParameterView,
  }, 
  {
    path: '/administration',
    name: 'administration',
    component: AdministrationView
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
