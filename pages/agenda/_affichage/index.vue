<template>
  <div>
    <b-container>
      <b-row>
        <b-col cols="2">
          <list-groups />
          <navigator-arrow
            @weekChangeEvent="weekChange($event)"
          />
          <formular :schedule-reference-date="day" />
        </b-col>
        <b-col cols="10">
          <schedule
            :days-of-the-week="getDaysOfTheWeek($route.fullPath)"
            :schedule-reference-date="day"
            :schedule-displayed-groups="scheduleDisplayedGroups"
            :schedule-height="scheduleHeight"
            class="schedule"
          />
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import ListGroups from '~/components/ListGroups.vue'
import NavigatorArrow from '~/components/Navigator/NavigatorArrow.vue'
import Formular from '~/components/AddCourse/Formular.vue'
import Schedule from '~/components/Schedule/Schedule.vue'
import addDays from '~/assets/js/addDays.js'
import { clearIdTarget } from '~/assets/js/targetId.js'
import { getReferenceDate, setReferenceDate } from '~/assets/js/referenceDate.js'

export default {
  components: {
    ListGroups,
    Schedule,
    NavigatorArrow,
    Formular
  },
  data () {
    console.log('data()')
    return {
      day: getReferenceDate(), // date initiale qu'affiche le schedule
      scheduleDisplayedGroups: [1, 2],
      user: null, // contains client - side rights
      scheduleHeight: 600
    }
  },
  head () {
    return {
      title: 'AMU edt'
    }
  },
  methods: {
    weekChange (event) {
      clearIdTarget()
      this.day = addDays(this.day, event)
      setReferenceDate(this.day)
    },
    getDaysOfTheWeek (data) {
      if (data === '/agenda/semaine/') { return 7 }
      if (data === '/agenda/jour/') { return 1 }
      return 7 // defaut
    }
  }
}
</script>

<style scoped>
.schedule { /* classe du composant schedule */
  position: relative;
  top: 10px;
}
</style>

<style>
.debug {
  font-family: monospace;
  color: red;
}
</style>
