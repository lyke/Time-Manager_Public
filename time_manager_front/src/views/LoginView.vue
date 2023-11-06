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
                                        <ion-icon name="mail-sharp"></ion-icon>
                                    </span>
                                </p>
                            </div>
                            <div class="field">
                                <p class="control has-icons-left">
                                    <input v-model="password" type="password" placeholder="Password" class="input" required>
                                    <span class="icon is-small is-left">
                                        <ion-icon name="key-sharp"></ion-icon>
                                    </span>
                                </p>
                            </div>
                            <div class="field">
                                <button class="button gradiant has-text-white" method="post" @click.prevent="sendPost()">Login</button>
                            </div>
                        </form>

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
import { notify } from "@kyvg/vue3-notification";

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
            axios
                .post("/login", postData)
                .then(res => {
                        localStorage.setItem("user_id", res.data.user_id);
                        this.$router.push({
                            name: "dashboard",
                            params: {id: localStorage.getItem("user_id")}
                        }) 
                    })
                .catch(function() {
                    notify({
                        title: "Something went wrong",
                        text: "Check your login informations",
                        duration: 7000,
                        pauseOnHover: true,
                        type: "error",
                    })
                });
        }
    }
};
</script>