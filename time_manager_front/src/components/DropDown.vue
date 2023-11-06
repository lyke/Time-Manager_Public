<template>
    <section class="hero">
        <div class="hero-body">
            <div class="columns">
                <label class="label column">User : {{ user.firstname }}</label>
            </div>

            <div class="columns is-vcentred">
                <div class="column">
                    <div class="dropdown" :class="{ 'is-active': isOpen }">
                        <div class="dropdown-trigger">
                            <button @click.prevent="openClose()" class="button" aria-haspopup="true" aria-controls="dropdown-menu3">
                                <span>{{ name }}</span>
                                <span class="icon is-small">
                                    <ion-icon name="chevron-down-sharp"></ion-icon>
                                </span>
                            </button>
                        </div>
                        <div class="dropdown-menu" id="dropdown-menu3" role="menu">
                            <div class="dropdown-content">
                                <a @click.prevent="selectedTeam = team" v-for="team in teams" :key="team.id" class="dropdown-item">
                                    {{ team.name }}
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="column">
                    <p>Add to : {{ selectedTeam.name }}</p>
                </div>

                <div class="column">
                    <button @click.prevent="AddUserToTeam()" class="button is-success">
                        <ion-icon name="person-add-sharp"></ion-icon>
                    </button>
                </div>
            </div>
        </div>
    </section>
    <br><br><br>
</template>

<script>
import axios from 'axios';
import { notify } from "@kyvg/vue3-notification";

export default {
    props: {
        name: {
            type: String,
            required: true,
        },
        user: {
            type: Object,
            required: true,
        }
    },
    data: function() {
        return {
            isOpen: false,
            teams: [],
            selectedTeam: '',
        }
    },
    methods: {
        getAllTeams() {
            axios
                .get('/teams')
                .then(res => {
                    this.teams = res.data.data;
                })
                .catch(function() {
                    notify({
                        title: "Something went wrong",
                        text: "Please try to refresh the page",
                        duration: 7000,
                        pauseOnHover: true,
                        type: "error",
                    })
                })
        },
        openClose() {
            this.isOpen = !this.isOpen;
        },
        AddUserToTeam() {
            const add = {
                "user_team": {
                    "user_id": this.user.id,
                    "team_id": this.selectedTeam.id,
                }
            }
            axios
                .post('/user_teams', add)
                .then(() => {
                    notify({
                        title: "Well done",
                        text: "Selected user has been added to the team",
                        duration: 7000,
                        pauseOnHover: true,
                        type: "success",
                    })
                })
                .catch(function() {
                    notify({
                        title: "Something went wrong",
                        text: "Please try again",
                        duration: 7000,
                        pauseOnHover: true,
                        type: "error",
                    })
                })
        }
    },
    mounted() {
        this.getAllTeams();
    }
}
</script>