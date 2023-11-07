import { createRouter, createWebHistory } from 'vue-router'
import LoginView from '../views/LoginView'
import RegisterView from '../views/RegisterView'
import TeamsView from '../views/TeamsView'
import DashboardView from '../views/DashboardView'
import ParameterView from '../views/ParameterView'
import AdministrationView from '../views/AdministrationView'
import CalendarView from '../views/CalendarView'
import GtsView from '../views/GtsView.vue'

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
    path: "/dashboard/:id",
    name: 'dashboard',
    component: DashboardView
  },
  {
    path: '/calendar/:id',
    name: 'calendar',
    component: CalendarView
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
  },
  {
    path: '/gts',
    name: 'gts',
    component: GtsView
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
