<template>
  <div class="teams">
    <div>
      <h1>Teams</h1>
      <div class="team-card">
        <h2 class="teams-title">Team 1</h2>
        <Users v-for="(user, index) in filteredManager" :firstname="user.firstname" :lastname="user.lastname" :role="user.role" :key="index"/>
        <Users v-for="(user, index) in filteredUsers" :firstname="user.firstname" :lastname="user.lastname" :role="user.role" :key="index"/>

      </div>


    </div>
    <Users v-for="(user, index) in users" :firstname="user.firstname" :lastname="user.lastname" :role="user.role" :key="index"/>
  </div>
</template>

<script>
// @ is an alias to /src
import Users from '@/components/Users.vue'

export default {
  name: 'TeamsView',
  components: {
    Users
  },
  data() {
    return {
      users: [
        { id: 1, firstname: 'John', lastname: 'Doe', email: 'john.doe@example.com', team: 1, role: 'manager', password: 'password' },
        { id: 2, firstname: 'Jane', lastname: 'Doe', email: 'jane.doe@example.com', team: 1, role: 'user', password: 'password' },
        { id: 3, firstname: 'John', lastname: 'Smith', email: 'jonh.smith@example.com', team: 1, role: 'user', password: 'password' },
        { id: 4, firstname: 'Jane', lastname: 'Smith', email: 'jane.smith@example.com', team: 2, role: 'manager', password: 'password' },
        { id: 5, firstname: 'John', lastname: 'Brown', email: 'jonh.brown@example.com', team: 2, role: 'user', password: 'password' },
        { id: 6, firstname: 'Jane', lastname: 'Brown', email: 'jane.brown@example.com', team: 2, role: 'user', password: 'password' }
      ]
    };
  },
  computed: {
  filteredUsers() {
    return this.users.filter(user => user.team === 1 && user.role === 'user');
  },
  filteredManager() {
    return this.users.filter(user => user.team === 1 && user.role === 'manager');
  }
}

}
</script>
<style>
.team-card {
  border: 1px solid lightgrey;
  box-shadow: 5px 5px 5px lightgrey;
  border-radius: 5px;
  padding: 10px;
  margin: 4vw;
  align-items: center;
  width: 30%;
}
.teams-title {
  font-weight: bold;
}
</style>
