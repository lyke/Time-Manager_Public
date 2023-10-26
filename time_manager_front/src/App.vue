<template>
  <nav>
    <router-link to="/">Login</router-link> |
    <router-link to="/teams">Teams</router-link> |
    <router-link to="/dashboard">Dashboard</router-link>
  </nav>
  <router-view/>
</template>

<style>
html {
  height: 100%;
}

body{
  min-height: 100%;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

nav {
  padding: 30px;
}

nav a {
  font-weight: bold;
  color: #2c3e50;
}

nav a.router-link-exact-active {
  color: #42b983;
}
</style>
