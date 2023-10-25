<template>
    <section class="hero">
        <div class="hero-body">
            <div class="container">
                <div class="columns">
                    <div class="column is-5-tablet is-4-desktop is-3-widescreen">
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

                    <div class="column is-5-tablet is-4-desktop is-3-widescreen">
                        <form action="" class="box">
                            <p><strong>Arrival and departure times</strong></p>
                            <div class="field">
                                <label for="timepicker-valid">Choose a time</label>
                                <b-form-timepicker id="datepicker-valid" :state="true"></b-form-timepicker>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>