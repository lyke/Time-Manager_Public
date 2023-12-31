<template>
    <NavMenu></NavMenu>
    <section class="hero">
        <div class="hero-body">
            <div class="columns is-centered">
                <div class="control column is-2">
                    <input v-model="teamName" type="text" class="input" placeholder="Team name">
                </div>
                <div class="column is-1">
                    <button class="button is-success" @click.prevent="createTeam()">Create team</button>
                </div>
            </div>
            <div class="box">
                <div class="columns is-vcentered">
                    <div class="column is-2">
                        <p class="label">Email</p>
                    </div>
                    <div class="column is-2">
                        <p class="label">Role</p>
                    </div>
                    <div class="column is-3">
                        <p class="label">Team</p>
                    </div>
                    <div class="column is-2">
                        <p class="label">Add to team</p>
                    </div>
                    <div class="column is-3">
                        <p class="label">Options</p>
                    </div>
                </div>
            </div>
            <div v-for="user in users" :key="user.id" class="box">
                <div class="columns is-vcentered">
                    <div class="column is-2">
                        <p>{{ user.email }}</p>
                    </div>
                    <div class="column is-2">
                        <p>{{ user.role }}</p>
                    </div>
                    <div class="column is-3">
                        <p v-if="user.role == 'super_manager'">Admin</p>
                        <p v-else-if="user.teams.length == 0">not assigned</p>
                        <label v-else v-for="team in user.teams" :key="team.id">{{ team.name }} <label></label></label>
                    </div>
                    <div class="column is-2">
                        <button v-if="user.role == 'user' && user.teams.length > 0" @click.prevent="openModal(user)" class="button is-success" disabled>
                            <ion-icon name="person-add-sharp"></ion-icon>
                        </button>
                        <button v-else-if="user.role != 'super_manager'" @click.prevent="openModal(user)" class="button is-success">
                            <ion-icon name="person-add-sharp"></ion-icon>
                        </button>
                        <div class="modal" :class="{ 'is-active': modalOpen }">
                            <div class="modal-background"></div>
                            <div class="modal-content">
                                <div class="box">
                                    <DropDown class="has-text-left" :name="'Teams'" :user="currentUser"></DropDown>
                                </div>
                            </div>
                            <button @click.prevent="closeModal" class="modal-close is-large" aria-label="close"></button>
                        </div>
                    </div>
                    <div class="column is-3">
                        <button v-if="user.role === 'user'" @click.prevent="updateUserToManager(user.id)" class="button is-info has-text-white mx-1">
                            <ion-icon name="chevron-up-sharp"></ion-icon>
                        </button>
                        <button v-if="user.role === 'manager'" @click.prevent="downgradeManagerToUser(user.id)" class="button is-warning has-text-black mx-1">
                            <ion-icon name="chevron-down-sharp"></ion-icon>
                        </button>
                        <button v-if="user.role === 'user' || user.role === 'manager'" @click.prevent="deleteUser(user.id)" class="button is-danger mx-1">
                            <ion-icon name="trash-bin-sharp"></ion-icon>
                        </button>
                        <router-link :to="{name:'dashboard', params: {id: user.id}} " class="button mx-1 is-success">
                            <ion-icon name="clipboard-sharp"></ion-icon>
                        </router-link>
                        <router-link :to="{name:'calendar', params: {id: user.id}} " class="button mx-1 is-success">
                            <ion-icon name="calendar-sharp"></ion-icon>
                        </router-link>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<script>
import axios from 'axios';
import NavMenu from '@/components/NavMenu.vue';
import DropDown from '@/components/DropDown.vue';
import { notify } from "@kyvg/vue3-notification";

export default {
    data: function() {
        return {
            users: [],
            teamName: '',
            modalOpen: false,
            currentUser: '',
        }
    },
    methods: {
        getAllUsers() {
            axios
                .get("/users")
                .then(res => {this.users = res.data.data;});
        },
        createTeam() {
            const team = {
                "team": {
                    name: this.teamName
                }
            }
            axios
                .post("/teams", team)
                .then(() => {
                    this.teamName = "";
                    notify({
                        title: "Well done",
                        text: "Team as been created",
                        duration: 7000,
                        pauseOnHover: true,
                        type: "success",
                    })
                });
        },
        updateUserToManager(id) {
            const user = {
                "user": {
                    "role": "manager"
                }
            }
            axios.put("/users/" + id, user)
        },
        downgradeManagerToUser(id) {
            const user = {
                "user": {
                    "role": "user"
                }
            }
            axios.put("/users/" + id, user)
        },
        deleteUser(id) {
            axios
                .delete("/users/" + id)
                .then(() => {
                    notify({
                        title: "Well done",
                        text: "User well deleted",
                        duration: 5000,
                        pauseOnHover: true,
                        type: "success",
                    });
                })
                .catch(function() {
                    notify({
                        title: "Something went wrong",
                        text: "Account not deleted, try again",
                        duration: 7000,
                        pauseOnHover: true,
                        type: "error",
                    });
                })
        },
        openModal(user) {
            this.currentUser = user;
            this.modalOpen = true;
        },
        closeModal() {
            this.modalOpen = false;
        },
        onKeyDown(event) {
            if (event.code === 'Escape') {
                this.closeModal();
            }
        },
    },
    mounted() {
        this.getAllUsers();
        document.addEventListener('keydown', this.onKeyDown);
    },
    updated() {
        this.getAllUsers();  
    },
    beforeUnmount() {
        document.removeEventListener('keydown', this.onKeyDown);
    },
    components: { 
        NavMenu,
        DropDown,
    }
}
</script>