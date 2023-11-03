<template>
    <NavMenu></NavMenu>
    <section class="hero">
        <div class="hero-body">
            <div class="columns box">
                <div class="column is-4">
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
                            <button @click.prevent="enableUpdateUserInputs()" class="button is-info mx-1">Edit</button>
                            <button @click.prevent="updateUser()" class="button is-success mx-1" id="update-user-button" method="put">Validate</button>
                            <button class="button is-danger mx-1">Delete</button>
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
                                <input v-model="team" type="text" class="input" disabled>
                            </div>
                        </div>
                        <div class="field" v-if="isManager">
                            <button class="button is-info">Edit</button>
                        </div>
                    </form>
                </div>

                <div class="column is-3">
                    <form action="" class="box">
                        <p><strong>Arrival and departure times</strong></p>
                        <br>
                        <div class="field">
                            <button id="clockin" class="button gradiant has-text-white" @click.prevent="clock()">Clock'in</button>
                        </div>
                        <div class="field">
                            <button class="button gradiant has-text-white" @click.prevent="clock()">Clock'out</button>
                        </div>
                    </form>
                    
                    <div class="box">
                        <p><strong>{{ new Date().toLocaleDateString('fr-FR') }}</strong></p>
                        <p>Arrival time : {{ clockin }}</p>
                        <p>Departure time : {{ clockout }}</p>
                    </div>
                </div>
                
                <div class="column is-5">
                    <div class="box">
                        <ChartDoughnut></ChartDoughnut>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<style>
#update-user-button {
    display: none;
}
</style>

<script>
import NavMenu from '@/components/NavMenu.vue';
import ChartDoughnut from '@/components/ChartDoughnut.vue'
// eslint-disable-next-line no-unused-vars
import { enableUpdateUserInputs, disableUpdateUserInputs } from '@/plugins/DashboardPlugin.js'
import { getCurrentTime } from '@/plugins/DatetimePlugin.js';
import { isUserManager } from '@/plugins/UserPlugin.js'
import axios from 'axios';

export default {
    data: function() {
        return {
            id: "",
            firstname: "",
            lastname: "",
            email: "",
            role: "",
            team: "",
            isManager: false,
            clockin: null,
            clockout: null
        };
    },
    methods: {
        getUser() {
            axios.get("/users/" + this.id)
                .then(res => {
                    this.id = res.data.data.id;
                    this.email = res.data.data.email;
                    this.firstname = res.data.data.firstname;
                    this.lastname = res.data.data.lastname;
                    this.role = res.data.data.role;
                    res.data.data.teams.forEach(team => {
                        this.team = team.name;
                    });
                    this.isManager = isUserManager();
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
            axios.put("/users/" + this.id, putUser).then(disableUpdateUserInputs());
        },
        clock() {
            const postClock = {
                "clock": {
                    time: getCurrentTime(),
                    fk_user: this.id
                }
            }
            axios.post("/clocks", postClock).then(document.getElementById("clockin").disabled = "true");
        },
        getTodayClocks() {
            axios
                .get('/users/' + this.id + '/today_clocks')
                .then(res => {
                    res.data.data.forEach(result => {
                        if(result.status === true) {
                            this.clockin = result.time.split("T")[1];
                        } else {
                            this.clockout = result.time.split("T")[1];
                        }
                    })
                });
        }
    },
    mounted() {
        this.id = localStorage.getItem("user_id");
        this.getUser();
        this.getTodayClocks();
    },
    components: { NavMenu, ChartDoughnut }
}
</script>