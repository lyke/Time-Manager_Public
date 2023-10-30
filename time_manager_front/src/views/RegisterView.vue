<template>
    <section class="hero">
        <div class="hero-body">
            <div class="container">
                <div class="columns is-centered">
                    <div class="column is-two-thirds">
                        <form action="" class="box" id="register-form">
                            <div class="field columns">
                                <div class="column">
                                    <label for="" class="label" name="firstName">First name</label>
                                    <div class="control">
                                        <input v-model="firstname" type="text" placeholder="e.g. Bob" class="input" required>
                                    </div>
                                </div>
                                <div class="column">
                                    <label for="" class="label">Last name</label>
                                    <div class="control">
                                        <input v-model="lastname" type="text" placeholder="e.g. Bobby" class="input" required>
                                    </div>
                                </div>
                            </div>
                            <div class="field">
                                <label for="" class="label">Email</label>
                                <div class="control">
                                    <input v-model="email" type="email" placeholder="e.g. bobsmith@gmail.com" class="input" required>
                                </div>
                            </div>
                            <div class="columns">
                                <div class="field column">
                                    <label for="" class="label">Password</label>
                                    <div class="control">
                                        <input v-model="password" type="password" placeholder="*******" class="input" min="10" required>
                                    </div>
                                </div>
                                <div class="field column">
                                    <label for="" class="label">Confirm password</label>
                                    <div class="control">
                                        <input type="password" placeholder="*******" class="input" min="10" required>
                                    </div>
                                </div>
                            </div>
                            <div class="field">
                                <button @click.prevent="sendPost()" class="button is-success" method="post">Register</button>
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
                            <p>Already an account ? <a href="/">Sign in</a></p>
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
        firstname: "",
        lastname: "",
        email: "",
        password: ""
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
            axios.defaults.baseURL = 'http://localhost:4000/api';
            axios
                .post("/users", postData)
                .then(res => {
                    console.log(res.body);
                })
                axios
                .post("/users", postData)
                .then(res => {
                console.log(res.body);
                })
                .catch(function (error){
                    document.getElementById("error").style.display = "block";
                    console.log(error);
                });
        },
        closeError() {
            document.getElementById("error").style.display = "none";
        }
    }
};
</script>