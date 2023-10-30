<template>
<div class="user">
  <h1 @click="routeToDashboard()">{{ firstname }} {{ lastname }}  : {{ role }}</h1>
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
h1:hover{
  color: grey;
}
</style>
