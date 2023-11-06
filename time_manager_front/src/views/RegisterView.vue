<template>
    <section class="hero">
        <div class="hero-body">
            <div class="container">
                <p class="title has-text-white">Regitser</p>
                <div class="columns is-centered">
                    <div class="column is-two-thirds">
                        <form action="" class="box" id="register-form">
                            <div class="field columns">
                                <div class="column">
                                    <div class="control">
                                        <input v-model="firstname" type="text" placeholder="First name" class="input" required>
                                    </div>
                                </div>
                                <div class="column">
                                    <div class="control">
                                        <input v-model="lastname" type="text" placeholder="Last name" class="input" required>
                                    </div>
                                </div>
                            </div>
                            <div class="field">
                                <div class="control">
                                    <input @focusout="handleFocusout()" v-model="email" :class="activeEmail ? 'is-primary' : 'is-danger'" id="email" type="email" placeholder="Email" class="input" required>
                                </div>
                            </div>
                            <div class="columns">
                                <div class="field column">
                                    <div class="control">
                                        <input v-model="password" id="password" type="password" placeholder="Password" class="input" min="10" required>
                                    </div>
                                </div>
                                <div class="field column">
                                    <div class="control">
                                        <input id="confirmPassword" type="password" placeholder="Confirm password" class="input" min="10" required>
                                    </div>
                                </div>
                            </div>
                            <div class="field">
                                <button @click.prevent="sendPost()" class="button gradiant has-text-white" method="post">Validate</button>
                            </div>
                        </form>
                        <div class="box">
                            <p>Already an account ? <a href="/">Sign in</a></p>
                            <a  href="#">CGU</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<script>
import axios from 'axios';
import { notify } from "@kyvg/vue3-notification";

export default {
    data: function() {
        return {
            firstname: "",
            lastname: "",
            email: "",
            password: "",
            activeEmail: null,
            activePassword: null,
        };
    },
    methods: {
        sendPost() {
            const postData = {
                "user": {
                    firstname: this.firstname, 
                    lastname: this.lastname,
                    email: this.email,
                    password: this.password,
                    role: "user"
                }
            };
            axios
                .post("/users", postData)
                .then(() => {
                    this.$router.push({name: "login"})
                })
                .catch(function() {
                    notify({
                        title: "Something went wrong",
                        text: "Check entered informations",
                        duration: 7000,
                        pauseOnHover: true,
                        type: "error",
                    })
                });
        },
        handleFocusout() {
            if(/^[^@]+@\w+(\.\w+)+\w$/.test(this.email) === false){
                notify({
                    title: "Something went wrong",
                    text: "Check the entered email",
                    duration: 7000,
                    pauseOnHover: true,
                    type: "error",
                })
            } else {
                this.activeEmail = true;
            }
        }
    }
};
</script>