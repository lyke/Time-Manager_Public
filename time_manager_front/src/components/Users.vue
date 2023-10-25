<template>
<div class="user">
  <h1 @click="routeToDashboard()">{{ firstname }} {{ lastname }}</h1>
  <!-- <p>{{ email }}</p> -->
  <!-- <p>{{ team }}</p> -->
  <p>{{ role }}</p>
  <!-- <p>{{ password }}</p> -->
</div>
</template>

<script>
export default {
  name: 'UserList',
  props: {
    firstname: String,
    lastname: String,
    email: String,
    team: Number,
    role: String,
    password: String
  },
  methods: {
    routeToDashboard() {
      this.$router.push('/dashboard')
    }
  }
}

</script>

<style>
</style>
