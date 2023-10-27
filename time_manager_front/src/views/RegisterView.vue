<template>
    <section class="hero">
        <div class="hero-body">
            <div class="container">
                <div class="columns is-centered">
                    <div class="column is-5-tablet is-4-desktop is-3-widescreen">
                        <form action="" class="box" id="register-form">
                            <div class="field">
                                <label for="" class="label" name="firstName">First name</label>
                                <div class="control">
                                    <input v-model="firstname" type="text" placeholder="e.g. Bob" class="input" required>
                                </div>
                            </div>
                            <div class="field">
                                <label for="" class="label">Last name</label>
                                <div class="control">
                                    <input v-model="lastname" type="text" placeholder="e.g. Bobby" class="input" required>
                                </div>
                            </div>
                            <div class="field">
                                <label for="" class="label">Email</label>
                                <div class="control">
                                    <input v-model="email" type="email" placeholder="e.g. bobsmith@gmail.com" class="input" required>
                                </div>
                            </div>
                            <div class="field">
                                <label for="" class="label">Password</label>
                                <div class="control">
                                    <input v-model="password" type="password" placeholder="*******" class="input" min="10" required>
                                </div>
                            </div>
                            <div class="field">
                                <label for="" class="label">Confirm password</label>
                                <div class="control">
                                    <input type="password" placeholder="*******" class="input" min="10" required>
                                </div>
                            </div>
                            <div class="field">
                                <button @click.prevent="sendPost()" class="button is-success" method="post">Register</button>
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
                .catch(function (error){
                    console.log(error);
                });
        }
    }
};
</script>