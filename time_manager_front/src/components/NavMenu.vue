<template>
    <nav>
        <router-link v-if="isSuperManager" to="/administration">Administration | </router-link>
        <router-link v-if="isManager" to="/teams">Teams | </router-link>
        <router-link :to="{name:'dashboard', params: {id: userId}}">Dashboard | </router-link>
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
      isSuperManager: false,
      isManager: false,
      role: "",
      userId: localStorage.getItem('user_id')
    }
  },
  methods: {
    isUserManager() {
      if (this.role === "manager") {
        this.isManager = true;
      } else {
        this.isManager = false; 
      }
    },
    isUserSuperManager() {
      if (this.role === "super_manager") {
        this.isSuperManager = true;
        this.isManager = true;
      } else {
        this.isSuperManager = false;
      }
    },
    getRole() {
      axios
        .get("/users/" + localStorage.getItem("user_id"))
        .then(res => {
            this.role = res.data.data.role;
            this.isUserManager();
            this.isUserSuperManager();
        });
    }
  },
  mounted() {
    this.getRole();
  }
}
</script>