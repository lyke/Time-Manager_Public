<template>
  <NavMenu></NavMenu>
  <section class="hero">
    <div class="hero-body">
      <div v-for="team in filteredTeams" :key="team.id">
        <div class="box my-4">
          <label class="label">Team {{ team.name }}</label>
        </div>

        <div v-for="user in team.user" :key="user.id">
          <div v-if="user.role == 'user'" class="box my-4 has-background-info has-text-white has-text-left">
            <div class="columns is-vcentered">
              <div class="column is-3">
                <p><strong class="has-text-white">First name :</strong> {{ user.firstname }}</p>
              </div>
              <div class="column is-3">
                <p><strong class="has-text-white">Last name :</strong> {{ user.lastname }}</p>
              </div>
              <div class="column is-4">
                <p><strong class="has-text-white">Email :</strong> {{ user.email }}</p>
              </div>
              <div class="column is-2 has-text-right">
                <button class="button is-success">
                  <ion-icon name="clipboard-sharp"></ion-icon>
                </button>
              </div>
            </div>
          </div>
          <div v-else-if="user.role == 'manager'" class="box my-4 has-background-warning has-text-black has-text-left">
            <div class="columns is-vcentered">
              <div class="column is-3">
                <p><strong class="has-text-black">First name :</strong> {{ user.firstname }}</p>
              </div>
              <div class="column is-3">
                <p><strong class="has-text-black">Last name :</strong> {{ user.lastname }}</p>
              </div>
              <div class="column is-4">
                <p><strong class="has-text-black">Email :</strong> {{ user.email }}</p>
              </div>
              <div class="column is-2 has-text-right">
                <button class="button is-success">
                  <ion-icon name="clipboard-sharp"></ion-icon>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import NavMenu from '@/components/NavMenu.vue';
import axios from 'axios';

export default{
  data: function() {
    return {
      teams: [],
      userTeams: [],
      role: '',
      id: '',
    }
  },
  methods: {
    getAllTeams() {
      axios.defaults.baseURL = "http://localhost:4000/api"
      axios
        .get("/teams")
        .then(res => {
          var teamsArray = res.data.data;
          teamsArray.forEach(team => {
            team.user.sort((a, b) => {
              if (a.role === "manager" && b.role !== "manager") {
                return -1;
              } else if (a.role !== "manager" && b.role === "manager") {
                return 1;
              } else {
                return 0;
              }
            });
          });
          
          this.teams = teamsArray;
        })
        .catch(function(error) {
          console.log(error);
        })
    },
    getUser() {
      const url = "http://localhost:4000/api/users/" + localStorage.getItem("user_id");
      axios
        .get(url)
        .then(res => {
          this.role = res.data.data.role;
          this.id = res.data.data.id;
        })
        .catch(function(error) {
          console.error('Error fetching user data:', error);
        });
    },
  },
  computed: {
    filteredTeams() {
      if (this.role === 'manager'){
        var filter = this.teams.filter(team =>
          team.user.some(user => user.id === this.id)
        );

        return filter;
      }

      return this.teams;
    }
  },
  mounted() {
    this.getUser();
    this.getAllTeams();
  },
  components: { NavMenu }
}
</script>