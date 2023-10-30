<template>
    <NavMenu></NavMenu>
    <section class="hero">
        <div class="hero-body">
            <div class="container">
                <div class="columns box">
                    <div class="column is-one-third">
                        <form action="" class="box">
                            <div class="field">
                                <label for="" class="label">Email :</label>
                            </div>
                            <div class="field">
                                <label for="" class="label">First name :</label>
                            </div>
                            <div class="field">
                                <label for="" class="label">Last name :</label>
                            </div>
                            <div class="field">
                                <label for="" class="label">Password : ******</label>
                            </div>
                            <div class="field">
                                <button class="button is-info mx-1">Edit</button>
                                <button class="button is-danger mx-1">Delete</button>
                            </div>
                        </form>

                        <form action="" class="box">
                            <div class="field">
                                <label for="" class="label">Role :</label>
                            </div>
                            <div class="field">
                                <label for="" class="label">Team :</label>
                            </div>
                            <div class="field">
                                <button class="button is-info">Edit</button>
                            </div>
                        </form>
                    </div>

                    <div class="column is-one-third">
                        <form action="" class="box">
                            <p><strong>Arrival and departure times</strong></p>
                            <div class="field">
                                <label for="timepicker-valid">Arrival time : </label>
                                <input type="time">
                            </div>
                            <div class="field">
                                <label for="timepicker-valid">Departure time : </label>
                                <input type="time">
                            </div>
                        </form>
                        
                        <div class="box">
                            <p><strong>{{ new Date().toLocaleDateString('fr-FR') }}</strong></p>
                            <p>Arrival time : </p>
                            <p>Departure time : </p>
                        </div>
                    </div>
                    
                    <div class="column is-one-third">
                        <div class="box">
                            <canvas id="myChart"></canvas>                        
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<script>
import NavMenu from '@/components/NavMenu.vue';
import Chart from 'chart.js/auto';

    export default{
    props: {
        user_id: String
    },
    mounted() {
        const ctx = document.getElementById('myChart');
        const data = {
            labels: [
                'Task 1',
                'Task 2',
                'Task 3'
            ],
            datasets: [{
                    label: 'My First Dataset',
                    data: [300, 50, 100],
                    backgroundColor: [
                        'rgb(255, 99, 132)',
                        'rgb(54, 162, 235)',
                        'rgb(255, 205, 86)'
                    ],
                    hoverOffset: 4
                }]
        };
        new Chart(ctx, { type: 'doughnut', data: data });
    },
    components: { NavMenu }
}
</script>