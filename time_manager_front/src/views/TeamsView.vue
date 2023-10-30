<template>
  <NavMenu></NavMenu>
  <div class="teams">
      <h1>Teams</h1>
      <div class="container">
        <div class="columns">

          <div class="column" v-for="team in teams" :key="team.id">
            <div class="box">
              <h2 class="teams-title">Team 1</h2>
              <p>
                <Users v-for="(user, index) in filteredManager" :firstname="user.firstname" :lastname="user.lastname" :role="user.role" :key="index"/>
                <Users v-for="(user, index) in filteredUsers" :firstname="user.firstname" :lastname="user.lastname" :role="user.role" :key="index"/>
              </p>
            </div>
          </div>

        </div>
      </div>


    <Users v-for="(user, index) in users" :firstname="user.firstname" :lastname="user.lastname" :role="user.role" :key="index"/>
  </div>
  <div>
    <h2>Teams List</h2>
    <ul>
      <li v-for="(team, index) in allTeamNumber()" :key="index">{{ team }}</li>
      <li v-for="(user, index) in filterUserByTeam()" :key="index">{{ user }}</li>
    </ul>
  </div>



  <div>
    <h1>Teams</h1>
    <ul>
      <li v-for="team in teams" :key="team.id">
        <h2>{{ team.name }}</h2>
        <ul>
          <li v-for="user in team.users" :key="user.id">
            <p>{{ user.firstname }} {{ user.lastname }}</p>
            <p>Email: {{ user.email }}</p>
          </li>
        </ul>
      </li>
    </ul>
  </div>
</template>

<script>
// @ is an alias to /src
import NavMenu from '@/components/NavMenu.vue';
import Users from '@/components/Users.vue'

export default {
  name: 'TeamsView',
  components: {
    Users,
    NavMenu
},
  // components: {
  //   Users
  // },
  // data() {
  //   return {
  //     users: [
  //       { id: 1, firstname: 'John', lastname: 'Doe', email: 'john.doe@example.com', team: 1, role: 'manager', password: 'password' },
  //       { id: 2, firstname: 'Jane', lastname: 'Doe', email: 'jane.doe@example.com', team: 1, role: 'user', password: 'password' },
  //       { id: 3, firstname: 'John', lastname: 'Smith', email: 'jonh.smith@example.com', team: 1, role: 'user', password: 'password' },
  //       { id: 4, firstname: 'Jane', lastname: 'Smith', email: 'jane.smith@example.com', team: 2, role: 'manager', password: 'password' },
  //       { id: 5, firstname: 'John', lastname: 'Brown', email: 'jonh.brown@example.com', team: 2, role: 'user', password: 'password' },
  //       { id: 6, firstname: 'Jane', lastname: 'Brown', email: 'jane.brown@example.com', team: 2, role: 'user', password: 'password' }
  //     ],
  //     teams: []
  //   };
  // },

  data() {
    return {
      teams: [],
      users: []
    };
  },

  mounted() {
    fetch('http://localhost:4000/teams')
      .then(response => response.json())
      .then(data => this.teams = data)
      // .then(data => this.teams.users = data)
      .catch(error => console.log(error));
  },


  computed: {
  filteredUsers() {
    if (this.teams) {
    return this.teams.filter(team => team.users === "user");
  } else {
    return [];
  }
    // return this.users.filter(user => user.role === 'user');
  },
  filteredManager() {
    if (this.teams) {
    return this.teams.filter(team => team.user === "manager");
  } else {
    return [];
  }
    // return this.users.filter(user => user.role === 'manager');
  }
},
  methods: {
    allTeamNumber() {
      // const teams = [];
      this.users.forEach(element => {
        if (this.teams.includes(element.team)) {
          return;
        } else {
          this.teams.push(element.team);
        }
      });
      return this.teams.sort();
    },
    filterUserByTeam(team) {
      return this.users.filter(user => user.team === team);
    },

    // filterUserByTeam() {
    //   this.teams.forEach(element => {
    //   const use = this.users.filter(user => user.team === element);
    //   // return use;

    //   // console.log(use);
    //   console.log(use.forEach(element => {
    //     return element.firstname;
    //   }));
    //   })
    // }
    // filterUserByTeam() {
    //   this.teams.forEach(element => {
    //     const team = [];
    //     const teamUsers = this.users.map(user => {
    //       if (user.team === element) {
    //         team.push(user);
    //       }
    //     });
    //     return team;

    //     console.log(team);
    //   });
    //   const userNamesByTeam = this.teams.map(team => {
    //     const usersInTeam = this.users.filter(user => user.team === team);
    //     return usersInTeam.map(user => user);
    //     return usersInTeam;
    //   });
    //   console.log(userNamesByTeam);
    // }

  }

}
</script>
<style scoped>
.teams-title {
  font-weight: bold;
}
</style>
