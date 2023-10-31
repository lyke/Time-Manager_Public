<template>
    <nav>
        <router-link to="/teams">Teams | </router-link>
        <router-link to="/dashboard">Dashboard | </router-link>
        <router-link to="/parameter">Parameter</router-link>
    </nav>
</template>

<style>
nav {
  padding: 20px;
}

nav a {
  font-weight: bold;
  color: white;
}

nav a.router-link-exact-active {
  color: #42b983;
}
</style>