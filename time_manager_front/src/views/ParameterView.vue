<template>
    <NavMenu></NavMenu>
    <section class="hero">
        <div class="hero-body has-text-left">
            <div class="box">
                <p class="title grey-color">Profil</p>
                <hr class="grey-backgroundcolor">
                <button  @click.prevent="logout()" class="button is-danger">Logout</button>
            </div>
        </div>
    </section>
</template>

<style>
.grey-color {
    color: #414650;
}

.grey-backgroundcolor {
    background-color: #414650;
}
</style>

<script>
import NavMenu from '@/components/NavMenu.vue';

export default{
    methods: {
        logout() {
            this.$router.push({name: "login"})
        }
    },
    components: { NavMenu }
}
</script>