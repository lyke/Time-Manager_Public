<template>
    <NavMenu></NavMenu>
    <section class="hero">
        <div class="hero-body">
            <div class="columns box">
                <div class="column is-4">
                   <UpdateUser></UpdateUser>
                </div>

                <div class="column is-3">
                    <GetClocks></GetClocks>
                </div>
                
                <div class="column is-5">
                    <div class="box">
                        <ChartDoughnut></ChartDoughnut>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<script>
import NavMenu from '@/components/NavMenu.vue';
import UpdateUser from '@/components/UpdateUser.vue';
import ChartDoughnut from '@/components/ChartDoughnut.vue'
import GetClocks from '@/components/GetClocks.vue';

export default {
    components: {
        NavMenu,
        ChartDoughnut,
        UpdateUser,
        GetClocks
    }
}
</script>