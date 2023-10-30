<template>
    <section class="hero">
        <div class="hero-body">
            <div class="container">
                <div class="columns is-centered">
                    <div class="column is-5-tablet is-4-desktop is-3-widescreen">
                        <form action="" class="box">
                            <div class="field">
                                <label for="" class="label">Email</label>
                                <div class="control">
                                    <input v-model="email" type="email" placeholder="e.g. bobsmith@gmail.com" class="input" required>
                                </div>
                            </div>
                            <div class="field">
                                <label for="" class="label">Password</label>
                                <div class="control">
                                    <input v-model="password" type="password" placeholder="*******" class="input" required>
                                </div>
                            </div>
                            <div class="field">
                                <label for="" class="checkbox">
                                    <input type="checkbox">Remember me
                                </label>
                            </div>
                            <div class="field">
                                <button class="button is-success" method="post" @click.prevent="sendPost()">Login</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>


<script>
import axios from 'axios';

export default {
    data: function() {
        return {
            email: "",
            password: ""
        };
    },
    methods: {
        sendPost() {
            const postData = {
                email: this.email,
                password: this.password,
            };
            axios.defaults.baseURL = 'http://localhost:4000/api';
            axios
                .post("/login", postData)
                .then(res => { 
                    var user_id = res.data.user_id;
                })
                .catch(function (error) { console.log(error); });
        }
    }
};
</script>