<template>
  <div style="height: 100%; width: 100%;">
    <b-container style="height: 100%; width: 100%;">
      <b-row>
        <b-col cols="4" class="cContainercol" style="height: 100%; width: 100%;">
          <div class="cContainer" style="height: 100%; width: 100%; position: relative;">
            <list-groups
              :list-groups="formularOptions.groups"
              @displayedGroupsEvent="displayedGroupsChange($event)"
            />
          </div>
          <div class="cContainer" style="height: 100%; width: 100%;position: relative;">
            <navigator-arrow
              @weekChangeEvent="weekChange($event)"
            />
          </div>
          <div v-if="isAdmin" class="cContainer" style="height: 100%; width: 100%;position: relative;">
            <b-button v-b-modal.modal-formular @click="setDeleteMode(false)">
              Nouveau cours
            </b-button>
            <br>
            <br>
            <b-button v-b-modal.modal-formular variant="danger" @click="setDeleteMode(true)">
              Supprimer le cours
            </b-button>
            <formular
              :schedule-reference-date="day"
              :selected-course="selectedCourse"
              :formular-options="formularOptions"
              :delete-mode="deleteMode"
              @calendarDateChangedEvent="dateChange($event)"
              @requestScheduleRefreshEvent="requestScheduleRefresh()"
            />
          </div>
          <div class="cContainer" style="height: 100%; width: 100%;position: relative;">
            <navigator-calendar
              :schedule-reference-date="day"
              @calendarDateChangedEvent="dateChange($event)"
            />
          </div>
        </b-col>
        <b-col cols="8">
          <div class="cContainer" style="height: 100%; width: 100%;" :style="{height: scheduleHeight + 200 +'px'}">
            <schedule
              ref="scheduleComponent"
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

  middleware: 'auth',

  data () {
    return {
      day: getReferenceDate(), // date initiale qu'affiche le schedule
      deleteMode: false,
      scheduleDisplayedGroups: [1], // défaut
      scheduleHeight: 600,
      selectedCourse: { isNull: null }, // cours clické
      formularOptions: { // Autocomplétion avec requete ou récupérer tout avant (une fois)
        ueName: [{ value: 'Algorithmique', text: 1 }, { value: 'Logique', text: 2 }, { value: 'Projet', text: 3 }],
        teacher: ['Line JAMET JAKUBIEC', 'Victor CEPOI', 'Séverine Fratanie'],
        groups: [{ value: 'l3info AIX', text: 1 }, { value: 'Luminy/L3 info', text: 2 }, { value: 'L2 chimie', text: 3 }],
        occurences: [{ text: 'Choisir une occurence', value: null }, { text: 'journalier', value: 1 }, { text: 'hebdomadaire', value: 7 }, { text: 'bihebdomadaire', value: 14 }, { text: 'mensuel', value: 30 }],
        campus: [{ value: 'Luminy', text: 1 }, { value: 'Aix en provence', text: 2 }, { value: 'Saint Charles', text: 3 }, { value: 'St Charles', text: 3 }],
        room: [{ value: 'A300', text: 1 }, { value: 'B302', text: 2 }, { value: 'B310', text: 3 }]
      }
    }
  },
  head () {
    return {
      title: 'AMU edt'
    }
  },
  computed: {
    isAdmin () {
      console.log(this.$auth.user.role)
      return this.$auth.user.role === 3 || this.$auth.user.role === 4
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
    displayedGroupsChange (event) {
      this.scheduleDisplayedGroups = event
    },
    setDeleteMode (state) {
      this.deleteMode = state
    },
    makeToast (status) {
      if (status !== 200) {
        this.$bvToast.toast(`Les suggestions n'ont pas pu être récupérés, code d'erreur: ${status}`, {
          title: 'Une erreur est survenue',
          autoHideDelay: 10000,
          variant: 'danger',
          appendToast: false
        })
      }
    },
    handleFetch (res) {
      this.makeToast(res.status)
      return res
    },
    requestScheduleRefresh () {
      this.$refs.scheduleComponent.scheduleRefresh()
    }
  }
}
</script>

<style scoped>
.schedule {
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
