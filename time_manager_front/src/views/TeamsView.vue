<template>
  <NavMenu></NavMenu>
  <section class="hero">
    <div class="hero-body">
      <div class="box">
        <p v-for="team in teams" :key="team.id">{{ team.name }}</p>
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
      teams: []
    }
  },
  methods: {
    getAllTeams() {
      axios.defaults.baseURL = "http://localhost:4000/api"
      axios
        .get("/teams")
        .then(res => {
          console.log(res.data.data);
          this.teams = res.data.data.teams;
        })
        .catch(function(error) {
          console.log(error);
        })
    }
  },
  mounted() {
    this.getAllTeams();
  },
  components: { NavMenu }
}
</script>