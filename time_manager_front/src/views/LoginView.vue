<template>
    <section class="hero">
        <div class="hero-body">
            <div class="container">
                <p class="title has-text-white">Login</p>
                <div class="columns is-centered">
                    <div class="column is-two-fifths">
                        <form action="" class="box">
                            <div class="field">
                                <p class="control has-icons-left">
                                    <input v-model="email" type="email" placeholder="Email" class="input" required>
                                    <span class="icon is-small is-left">
                                        <ion-icon name="mail-outline"></ion-icon>
                                    </span>
                                </p>
                            </div>
                            <div class="field">
                                <p class="control has-icons-left">
                                    <input v-model="password" type="password" placeholder="Password" class="input" required>
                                    <span class="icon is-small is-left">
                                        <ion-icon name="key-outline"></ion-icon>
                                    </span>
                                </p>
                            </div>
                            <div class="field">
                                <button class="button gradiant has-text-white" method="post" @click.prevent="sendPost()">Login</button>
                            </div>
                        </form>

                        <article class="message is-danger" id="error">
                            <div class="message-header">
                                <p>Error</p>
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
                        localStorage.setItem("user_id", res.data.user_id);
                        this.$router.push({
                            name: "dashboard"
                        }) 
                    })
                .catch(function(error) {
                    console.log(error)
                    document.getElementById("error").style.display = "block"; 
                });
        },
        closeError() {
            document.getElementById("error").style.display = "none";
        }
    }
};
</script>