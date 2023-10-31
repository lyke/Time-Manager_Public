<template>
    <NavMenu></NavMenu>
    <section class="hero">
        <div class="hero-body">
            <div class="container">
                <div class="box">
                    <div class="columns is-vcentered">
                        <div class="column">
                            <p class="label">Email</p>
                        </div>
                        <div class="column">
                            <p class="label">Role</p>
                        </div>
                        <div class="column">
                            <p class="label">Team</p>
                        </div>
                        <div class="column">
                            <p class="label">Options</p>
                        </div>
                    </div>
                </div>
                <div v-for="user in users" :key="user.id" class="box">
                    <div class="columns is-vcentered">
                        <div class="column">
                            <p>{{ user.email }}</p>
                        </div>
                        <div class="column">
                            <p>{{ user.role }}</p>
                        </div>
                        <div class="column">
                            <p v-if="user.role == 'super_manager'">admin</p>
                            <p v-else-if="user.teams.length == 0">not assigned</p>
                            <label v-else v-for="team in teams" :key="team.id">{{ team.name }} </label>
                        </div>
                        <div class="column is-one-quarter">
                            <button v-if="user.role === 'user'" class="button is-info has-text-white mx-1">
                                <ion-icon name="chevron-up-outline"></ion-icon>
                            </button>
                            <button v-if="user.role === 'user' || user.role === 'manager'" class="button is-danger mx-1">
                                <ion-icon name="trash-bin-outline"></ion-icon>
                            </button>
                            <button class="button mx-1 is-success">
                                <ion-icon name="clipboard-outline"></ion-icon>
                            </button>
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

export default {
    data: function() {
        return {
            users: []
        }
    },
    methods: {
        getAllUsers() {
            axios.defaults.baseURL = 'http://localhost:4000/api';
            axios
                .get("/users")
                .then(res => {
                    this.users = res.data.data;
                })
                .catch(function(error) {
                    console.log(error)
                })
        }
    },
    mounted() {
        this.getAllUsers();
    },
    components: { NavMenu }
}
</script>