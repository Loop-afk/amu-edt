<template>
  <div style="height: 100%; width: 100%;">
    <b-container style="height: 100%; width: 100%;">
      <b-row>
        <b-col cols="4" class="cContainercol" style="height: 100%; width: 100%;">
          <div class="cContainer" style="height: 100%; width: 100%; position: relative;">
            <list-groups :list-groups="formularOptions.groups" />
          </div>
          <div class="cContainer" style="height: 100%; width: 100%;position: relative;">
            <navigator-arrow
              @weekChangeEvent="weekChange($event)"
            />
          </div>
          <div class="cContainer" style="height: 100%; width: 100%;position: relative;">
            <b-button v-b-modal.modal-formular>
              Nouveau cours
            </b-button>
            <formular
              :schedule-reference-date="day"
              :selected-course="selectedCourse"
              :formular-options="formularOptions"
            />
          </div>
          <div class="cContainer" style="height: 100%; width: 100%;position: relative;">
            <navigator-calendar
              :schedule-reference-date="day"
              @calendarDateChangedEvent="dateChange($event);"
            />
          </div>
        </b-col>
        <b-col cols="8">
          <div class="cContainer" style="height: 100%; width: 100%;" :style="{height: scheduleHeight + 200 +'px'}">
            <schedule
              :displayed-days="getDaysDisplayed($route.params.affichage)"
              :schedule-reference-date="day"
              :schedule-displayed-groups="scheduleDisplayedGroups"
              :schedule-height="scheduleHeight"
              :allow-course-click-event="true"
              class="schedule"
              @courseClickedEvent="courseChange($event)"
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
import NavigatorCalendar from '~/components/Navigator/NavigatorCalendar.vue'

export default {
  components: {
    ListGroups,
    Schedule,
    NavigatorArrow,
    Formular,
    NavigatorCalendar
  },
  data () {
    return {
      day: getReferenceDate(), // date initiale qu'affiche le schedule
      scheduleDisplayedGroups: [1, 2],
      user: null, // contient client - side rights /!\ do not trust
      scheduleHeight: 600,
      selectedCourse: {},
      formularOptions: { // Autocomplétion avec requete ou récupérer tout avant (une fois)
        title: ['Algorithmique', 'Logique', 'Projet'],
        teacher: ['Line JAMET JAKUBIEC', 'Victor CEPOI', 'Séverine Fratanie'],
        groups: ['Aix/L3 info', 'Luminy/L3 info', 'L2 chimie'],
        occurences: [{ text: 'Choisir une occurence', value: null }, { text: 'spontané', value: 0 }, { text: 'journalier', value: 1 }, { text: 'hebdomadaire', value: 7 }, { text: 'bihebdomadaire', value: 14 }, { text: 'mensuel', value: 30 }],
        duration: [{ text: 'Choisir une durée', value: null }, { text: 'spontané', value: 0 }, { text: '1 semaine', value: 7 }, { text: 'semi-semestriel', value: 45 }, { text: 'semestriel', value: 90 }, { text: 'annuel', value: 365 }],
        campus: [{ text: 'Luminy', value: 1 }, { text: 'Aix en provence', value: 2 }, { text: 'Saint Charles', value: 3 }, { text: 'St Charles', value: 3 }],
        room: [{ text: 'A300', value: 1 }, { text: 'B302', value: 2 }, { text: 'B310', value: 3 }]
      }
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
    dateChange (event) {
      clearIdTarget()
      this.day = event
      setReferenceDate(this.day)
    },
    getDaysDisplayed (data) {
      if (data === 'jour') { return 1 }
      return 7 // semaine et autre
    },
    courseChange (event) {
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
