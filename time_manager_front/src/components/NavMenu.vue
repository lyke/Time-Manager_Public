<template>
    <nav>
        <router-link v-if="isManager" to="/teams">Teams | </router-link>
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

<script>
import axios from 'axios';

export default {
  data: function() {
    return {
      isManager: false,
      role: ""
    }
  },
  methods: {
    isUserManager() {
      if (this.role === "manager" || this.role === "super_manager") {
        this.isManager = true;
      } else {
        this.isManager = false; 
      }
    },
    getRole() {
      const url = "http://localhost:4000/api/users/" + localStorage.getItem("user_id");
      axios
        .get(url)
        .then(res => {
            this.role = res.data.data.role;
        })
        .catch(function(error) {
            console.error('Error fetching user data:', error);
        });
    }
  },
  mounted() {
    this.getRole();
    this.isUserManager();
  }
}
</script>