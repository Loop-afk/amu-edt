<template>
  <div style="height: 100%; width: 100%;">
    <b-container style="height: 100%; width: 100%;">
      <b-row>
        <b-col cols="4" class="Ckdulzcontainercol" style="height: 100%; width: 100%;">
          <div class="Ckdulzcontainer" style="height: 100%; width: 100%; position: relative;">
            <list-groups />
          </div>
          <div class="Ckdulzcontainer" style="height: 100%; width: 100%;position: relative;">
            <navigator-arrow
              @weekChangeEvent="weekChange($event)"
            />
          </div>
          <div class="Ckdulzcontainer" style="height: 100%; width: 100%;position: relative;">
            <b-button v-b-modal.modal-1>
              Nouveau cours
            </b-button>
          </div>
          <b-modal id="modal-1" title="Nouveau cours" scrollable centered>
            <formular
              :schedule-reference-date="day"
              :selected-course="selectedCourse"
            />
          </b-modal>
        </b-col>
        <b-col cols="8">
          <div class="Ckdulzcontainer" style="height: 100%; width: 100%;" :style="{height: scheduleHeight + 200 +'px'}">
            <schedule
              :displayed-days="getDaysDisplayed($route.params.affichage)"
              :schedule-reference-date="day"
              :schedule-displayed-groups="scheduleDisplayedGroups"
              :schedule-height="scheduleHeight"
              class="schedule"
              @courseClickedEvent="courseChange($event, schedule)"
            />
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import ListGroups from '~/components/Navigator/ListGroups.vue'
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
      if (data === 'jour') { return 1 }
      return 7 // defaut
    },
    courseChange (event, schedule) {
      this.selectedCourse = event
    },
    deleteCourse (course, schedule) {
      delete schedule[schedule.indexOf(course)]
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
