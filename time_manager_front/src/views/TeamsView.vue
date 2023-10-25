<template>
  <div class="teams">
    <Users v-for="(user, index) in users" :firstname="user.firstname" :lastname="user.lastname" :role="user.role" :key="index"/>
    <!-- {{ Users }} -->
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
  }
}
</script>
