<template>
    <canvas id="myChart"></canvas>
</template>

<script>
import axios from 'axios';
import Chart from 'chart.js/auto';
import { notify } from "@kyvg/vue3-notification";

export default {
    data: function() {
        return {
            creditTime: 0,
            color: "",
        };
    },
    methods: { 
        setupChart() {
            const ctx = document.getElementById('myChart');
            const data = {
                labels: [
                    'Credit time : ' + this.creditTime,
                ],
                datasets: [{
                    label: 'Time manager chart',
                    data: [parseInt(this.creditTime)],
                    backgroundColor: [
                        this.color,
                    ],
                    hoverOffset: 4
                }]
            };
            new Chart(ctx, { type: 'doughnut', data: data });
        },
        getCreditTime() {
            axios
                .get("/users/time_credit/" + this.$route.params.id)
                .then(res => { 
                    this.creditTime = res.data.time_credit_in_minutes;
                    this.calculCreditTime(this.creditTime);
                    try {
                        this.setupChart();
                    }
                    catch {
                        notify({
                            title: "Loading ...",
                            text: "Chart take time to load",
                            duration: 4000,
                            pauseOnHover: true,
                        })
                    }
                });
        },
        calculCreditTime(time) {
            if (time > 0) {
                this.color = "rgb(50,205,50)";
            } else {
                this.color = "rgb( 255,97,102";
            }
        }
    },
    mounted() {
        this.getCreditTime();
    }
}
</script>