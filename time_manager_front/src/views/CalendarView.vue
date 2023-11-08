<template>
    <NavMenu></NavMenu>
    <section class="hero">
        <div class="hero-body">
            <div class="box">
                <FullCalendar ref="calendar" :options='calendarOptions'/>
            </div>
        </div>
    </section>
</template>

<script>
import NavMenu from '@/components/NavMenu.vue';
import FullCalendar from '@fullcalendar/vue3'
import dayGridPlugin from '@fullcalendar/daygrid'
import axios from 'axios';
import { notify } from "@kyvg/vue3-notification";

export default {
    components: {
        NavMenu,
        FullCalendar
    },
    data: function() {
        return {
            clocksArray: [],
            calendarOptions: {
                plugins: [dayGridPlugin],
                initialView: 'dayGridWeek',
                weekends: false,
                timeZone: 'UTC',
                events: [
                    // Long event exemple
                    // {
                    //     title: 'Event 2',
                    //     start: '2023-11-08',
                    //     end: '2023-12-08',
                    // },
                ],
                headerToolbar: { 
                    right: 'dayGridYear,dayGridMonth,dayGridWeek,dayGridDay', 
                    center: 'title', 
                    left: 'prev,next'
                }
            }
        }
    },
    methods: {
        getAllClocks() {
            axios
                .get("/clocks/" + this.$route.params.id)
                .then(res => {
                    this.clocksArray = res.data.data;
                    this.populateEvents(this.clocksArray);
                });
        },
        populateEvents(array) {
            const events = array.map(event => ({
                allDay: false,
                title: event.status ? 'Clock in' : 'Clock out',
                start: event.time,
            }));

            try {
                this.$refs.calendar.getApi().addEventSource(events);
            } catch {
                notify({
                    title: "Loading ...",
                    text: "Calendar take time to load",
                    duration: 4000,
                    pauseOnHover: true,
                })
            }
        }
    },
    mounted() {
        this.getAllClocks();
    }
}
</script>