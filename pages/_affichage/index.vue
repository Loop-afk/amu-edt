<template>
  <div>
    <b-container>
      <b-row>
        <b-col cols="2">
          <list-groups />
          <navigator-arrow @weekChangeEvent="weekChange($event)" />
          <formular />
        </b-col>
        <b-col cols="10">
          <schedule
            :days-of-the-week="getDaysOfTheWeek($route.fullPath)"
            :schedule-settings-date="day"
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

export default {
  components: {
    ListGroups,
    Schedule,
    NavigatorArrow,
    Formular
  },
  layout: 'default',
  data () {
    return {
      day: new Date(), // date initiale qu'affiche le schedule
      scheduleDisplayedGroups: [1, 2],
      scheduleHeight: 600
    }
  },
  head () {
    return {
      title: 'AMU edt'
    }
  },
  computed: {

  },
  methods: {
    weekChange (event) {
      let offset
      clearIdTarget()
      // à optimiser
      if (event === 'right') { offset = 7 } else if (event === 'left') { offset = -7 } else { console.warn('Illegal value from weekChange event: ' + event) }
      this.day = addDays(this.day, offset)
    },
    getDaysOfTheWeek (data) {
      if (data === '/semaine/') { return 7 }
      if (data === '/jour/') { return 1 }
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
