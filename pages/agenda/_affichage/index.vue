<template>
  <div>
    <b-container>
      <b-row>
        <b-col cols="4">
          <list-groups />
          <navigator-arrow
            @weekChangeEvent="weekChange($event)"
          />
          <formular
            :schedule-reference-date="day"
            :selected-course="selectedCourse"
          />
        </b-col>
        <b-col cols="8">
          <schedule
            :days-of-the-week="getDaysDisplayed($route.fullPath)"
            :schedule-reference-date="day"
            :schedule="schedule"
            :schedule-displayed-groups="scheduleDisplayedGroups"
            :schedule-height="scheduleHeight"
            class="schedule"
            @courseClickedEvent="courseChange($event, schedule)"
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
import { getSchedule, setSchedule } from '~/assets/js/schedule.js'

export default {
  components: {
    ListGroups,
    Schedule,
    NavigatorArrow,
    Formular
  },
  async asyncData () { // todo virer working hour du json
    if (getSchedule() != null) { return }
    const schedule = await fetch('http://192.168.1.36:18929/schedule/')
      .then(res => res.json())
      .then((data) => { return { schedule: data } })
    setSchedule(0) // à remplacer par vuex.store
    return schedule
  },
  data () {
    return {
      day: getReferenceDate(), // date initiale qu'affiche le schedule
      scheduleDisplayedGroups: [1, 2],
      user: null, // contient client - side rights /!\ do not trust
      scheduleHeight: 600,
      selectedCourse: null
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
    getDaysDisplayed (data) {
      // if (data === '/agenda/semaine/') { return 7 }
      if (data === '/agenda/jour/') { return 1 }
      return 7 // defaut
    },
    courseChange (event, schedule) {
      console.log('clicked in index')
      this.selectedCourse = event
      // this.deleteCourse(event, schedule)
    },
    deleteCourse (course, schedule) {
      delete schedule.data[schedule.data.indexOf(course)]
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
