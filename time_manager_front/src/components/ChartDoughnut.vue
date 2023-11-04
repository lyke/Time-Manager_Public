<template>
    <canvas id="myChart"></canvas>
</template>

<script>
import Chart from 'chart.js/auto';

export default {
    methods: { 
        setupChart() {
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
        }
    },
    mounted() {
        this.setupChart();
    }
}
</script>