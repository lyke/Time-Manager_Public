<template>
    <form class="box">
        <div class="field columns">
            <label class="label column">Email : </label>
            <div class="control">
                <input v-model="email" type="text" class="input" name="email" disabled>
            </div>
        </div>
        <div class="field columns">
            <label for="" class="label column">First name : </label>
            <div class="control">
                <input v-model="firstname" type="text" class="input" name="firstname" disabled>
            </div>
        </div>
        <div class="field columns">
            <label for="" class="label column">Last name : </label>
            <div class="control">
                <input v-model="lastname" type="text" class="input" name="lastname" disabled>
            </div>
        </div>
        <div class="field columns">
            <label for="" class="label column">Password : </label>
            <div class="control">
                <input v-model="password" type="text" class="input" name="password" placeholder="*****" disabled>
            </div>
        </div>
        <div class="field">
            <button @click.prevent="enableInputs()" class="button is-info mx-1">Edit</button>
            <button @click.prevent="updateUser()" class="button is-success mx-1" id="update-user-button" method="put">Validate</button>
            <button @click.prevent="deleteUser()" class="button is-danger mx-1">Delete</button>
        </div>
    </form>

    <form action="" class="box">
        <div class="field columns">
            <label class="label column">Role : </label>
            <div class="control">
                <input v-model="role" type="text" class="input" disabled>
            </div>
        </div>
        <div class="field columns">
            <label class="label column">Team : </label>
            <div class="control">
                <input v-if="isSuperManager" placeholder="Admin" type="text" class="input" disabled>
                <input v-else v-model="team" type="text" class="input" disabled>
            </div>
        </div>
        <div class="field" v-if="isManager">
            <button class="button is-info">Edit</button>
        </div>
    </form>
</template>

<style>
#update-user-button {
    display: none;
}
</style>

<script>
import { enableUpdateUserInputs, disableUpdateUserInputs } from '@/plugins/DashboardPlugin.js'
import { isUserManager, isUserSuperManager } from '@/plugins/UserPlugin.js'
import axios from 'axios';
import { notify } from "@kyvg/vue3-notification";

export default {
    data: function() {
        return {
            firstname: "",
            lastname: "",
            email: "",
            role: "",
            team: "",
            isManager: false,
            isSuperManager: false,
        };
    },
    methods: {
        getUser() {
            axios.get("/users/" + this.$route.params.id)
                .then(res => {
                    this.email = res.data.data.email;
                    this.firstname = res.data.data.firstname;
                    this.lastname = res.data.data.lastname;
                    this.role = res.data.data.role;
                    res.data.data.teams.forEach(team => {
                        this.team = team.name;
                    });
                    this.isManager = isUserManager(this.role);
                    this.isSuperManager = isUserSuperManager(this.role);
                });
        },
        updateUser() {
            const putUser = {
                "user": {
                    email: this.email,
                    firstname: this.firstname,
                    lastname: this.lastname,
                    password: this.password
                }
            }
            axios.put("/users/" + this.$route.params.id, putUser).then(disableUpdateUserInputs());
        },
        deleteUser() {
            axios
                .delete("/users/" + this.$route.params.id)
                .then(() => {
                    this.$router.push({name: "login"});
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
        enableInputs() {
            enableUpdateUserInputs();
        }
    },
    mounted() {
        this.getUser();
    }
}
</script>