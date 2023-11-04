<template>
    <form action="" class="box">
        <p><strong>Arrival and departure times</strong></p>
        <br>
        <form>
            <div class="field">
                <button id="clockin" class="button gradiant has-text-white" @click.prevent="clockIn()" method="put">Clock'in</button>
            </div>
        </form>
        <form>
            <div class="field">
                <button id="clockout" class="button gradiant has-text-white" @click.prevent="clockOut()" method="put">Clock'out</button>
            </div>
        </form>
    </form>

    <div class="box">
        <p><strong>{{ new Date().toLocaleDateString('fr-FR') }}</strong></p>
        <p>Arrival time : <label id="arrival">{{ clockin }}</label></p>
        <p>Departure time : <label id="departure">{{ clockout }}</label></p>
    </div>
</template>

<script>
import { getCurrentTime } from '@/plugins/DatetimePlugin.js';
import axios from 'axios';

export default {
    data: function() {
        return {
            clockin: null,
            clockout: null
        };
    },
    methods: {
        clockIn(){
            this.clock("clockin");
        },
        clockOut(){
            this.clock("clockout");
        },
        clock(clockButton) {
            const postClock = {
                "clock": {
                    time: getCurrentTime(),
                    fk_user: this.$route.params.id
                }
            }
            axios
                .post("/clocks", postClock)
                .then(() => {
                    document.getElementById(clockButton).disabled = "true";
                    this.getTodayClocks();
                });
        },
        getTodayClocks() {
            axios
                .get('/users/' + this.$route.params.id + '/today_clocks')
                .then(res => {
                    res.data.data.forEach(result => {
                        if(result.status === true) {
                            this.clockin = result.time.split("T")[1];
                            document.getElementById("clockin").disabled = "true";
                        } else {
                            this.clockout = result.time.split("T")[1];
                            document.getElementById("clockout").disabled = "true";
                        }
                    })
                });
        }
    },
    mounted() {
        this.getTodayClocks();
    }
}
</script>