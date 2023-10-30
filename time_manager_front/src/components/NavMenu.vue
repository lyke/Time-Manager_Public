<template>
    <div class="columns">
        <div class="column is-full">
            <nav>
                <router-link to="/teams">Teams</router-link> |
                <router-link to="/dashboard/:user_id">Dashboard</router-link>
            </nav>
            <a href="/" class="button is-danger is-outlined">Logout</a>
        </div>
    </div>
</template>