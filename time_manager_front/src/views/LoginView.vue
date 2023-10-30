<template>
    <section class="hero">
        <div class="hero-body">
            <div class="container">
                <div class="columns is-centered">
                    <div class="column is-two-fifths">
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

                        <article class="message is-danger" id="error">
                            <div class="message-header">
                                <p>Danger</p>
                                <button class="delete" aria-label="delete" @click.prevent="closeError()"></button>
                            </div>
                            <div class="message-body">
                                An error occur, please try again
                            </div>
                        </article>

                        <div class="box">
                            <p>Don't have an account ? <a href="/register">Sign up</a></p>
                            <a  href="#">CGU</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<style>
#error {
    display: none;
}
</style>

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
                        this.$router.push({
                            path: "/dashboard", params: { user_id}
                        }) 
                    })
                .catch(function() {
                    document.getElementById("error").style.display = "block"; 
                });
        },
        closeError() {
            document.getElementById("error").style.display = "none";
        }
    }
};
</script>