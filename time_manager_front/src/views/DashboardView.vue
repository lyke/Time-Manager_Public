<template>
    <NavMenu></NavMenu>
    <section class="hero">
        <div class="hero-body">
            <div class="container">
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
                                <button @click.prevent="enableInputs()" class="button is-info mx-1">Edit</button>
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
                                <button class="button gradiant has-text-white" @click.prevent="clockIn()">Clock'in</button>
                            </div>
                            <div class="field">
                                <button class="button gradiant has-text-white" @click.prevent="clockOut()">Clock'out</button>
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
                            <canvas id="myChart"></canvas>                        
                        </div>
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
import Chart from 'chart.js/auto';
import axios from 'axios';

    export default{
        props: {
            user_id: String
        },
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
                axios.defaults.baseURL = 'http://localhost:4000/api';
                axios
                    .get("/users")
                    .then(res => {
                        if (Array.isArray(res.data.data)) { res.data.data.forEach(user => {
                                this.id = user.id;
                                this.email = user.email;
                                this.firstname = user.firstname;
                                this.lastname = user.lastname;
                                this.role = user.role;
                                this.team = user.team;
                            });
                        } else {
                            console.error('Users not found:', res.data);
                        }

                        this.isUserManager();
                    })
                    .catch(function(error) {
                        console.error('Error fetching user data:', error);
                    });
            },
            hide() {
                document.getElementsByName("email")[0].disabled = true;
                document.getElementsByName("firstname")[0].disabled = true;
                document.getElementsByName("lastname")[0].disabled = true;
                document.getElementsByName("password")[0].disabled = true;
                document.getElementById("update-user-button").style.display = "none";
            },
            enableInputs() {
                var updateUserButton = document.getElementById("update-user-button").style.display;
                if (updateUserButton == "initial") {
                    this.hide();
                } else {
                    document.getElementsByName("email")[0].disabled = false;
                    document.getElementsByName("firstname")[0].disabled = false;
                    document.getElementsByName("lastname")[0].disabled = false;
                    document.getElementsByName("password")[0].disabled = false;
                    document.getElementById("update-user-button").style.display = "initial";
                }
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

                axios.defaults.baseURL = 'http://localhost:4000/api';
                axios
                    .put("/users/" + this.id, putUser)
                    .then(
                        this.hide()
                    )
                    .catch(function(error) {
                        console.log(error);
                    })
            },
            isUserManager() {
                if (this.role === "manager" || this.role === "super_manager") {
                    this.isManager = true;
                } else {
                    this.isManager = false; 
                }
            },
            getCurrentTime() {
                var date = new Date();
                const year = date.getFullYear();
                const month = date.getMonth() + 1;
                const day = date.getDate();
                const hours = date.getHours();
                const formattedHours = hours < 10 ? '0' + hours : hours;
                const minutes = date.getMinutes();
                const formattedMinutes = minutes < 10 ? '0' + minutes : minutes;

                return year + "-" + month + "-" + day + "T" + formattedHours + ":" + formattedMinutes;
            },
            clockIn() {
                const postClock = {
                    "clock": {
                        time: this.clockin = this.getCurrentTime(),
                        status: "true",
                        fk_user: this.id
                    }
                }

                axios.defaults.baseURL = 'http://localhost:4000/api';
                axios
                    .post("/clocks", postClock)
                    .then()
                    .catch(function(error) {
                        console.log(error);
                    })
            },
            clockOut() {
                const postClock = {
                    "clock": {
                        time: this.clockin = this.getCurrentTime(),
                        status: "false",
                        fk_user: this.id
                    }
                }

                axios.defaults.baseURL = 'http://localhost:4000/api';
                axios
                    .post("/clocks", postClock)
                    .then()
                    .catch(function(error) {
                        console.log(error);
                    })
            }
        },
        mounted() {
            this.getUser();
            
            const ctx = document.getElementById('myChart');
            const data = {
                labels: [
                    'Task 1',
                    'Task 2',
                    'Task 3'
                ],
                datasets: [{
                        label: 'My First Dataset',
                        data: [300, 50, 100],
                        backgroundColor: [
                            'rgb(255, 99, 132)',
                            'rgb(54, 162, 235)',
                            'rgb(255, 205, 86)'
                        ],
                        hoverOffset: 4
                    }]
            };
            new Chart(ctx, { type: 'doughnut', data: data });
        },
        components: { NavMenu }
}
</script>