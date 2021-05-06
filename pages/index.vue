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
            :schedule-settings-date="day"
            :schedule-schedule="schedule"
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
    schedule () {
      return {
        workingHours: {
          start: 4,
          end: 24
        },
        data: [
          {
            day: '03/05/2021',
            group: [2],
            start: {
              hours: 15,
              minutes: 15
            },
            end: {
              hours: 18,
              minutes: 15
            },
            title: 'First Event Ever!',
            teacher: 'Nobody :(',
            room: 'Home'
          },
          {
            day: '05/05/2021',
            group: [1, 2],
            start: {
              hours: 8,
              minutes: 15
            },
            end: {
              hours: 11,
              minutes: 45
            },
            title: 'Second Event',
            teacher: 'Still Nobody :(',
            room: 'Home'
          },
          {
            day: '04/05/2021',
            group: [1],
            start: {
              hours: 6,
              minutes: 0
            },
            end: {
              hours: 20,
              minutes: 0
            },
            title: 'Third Event',
            teacher: 'Nobody',
            room: 'Home'
          },
          {
            day: '09/05/2021',
            group: [1],
            start: {
              hours: 7,
              minutes: 45
            },
            end: {
              hours: 10,
              minutes: 0
            },
            title: 'Fourth Event',
            teacher: 'Nobody.',
            room: 'Home.'
          }
        ]
      }
    }
  },
  methods: {
    weekChange (event) {
      let offset
      clearIdTarget()
      if (event === 'right') { offset = 7 } else if (event === 'left') { offset = -7 } else { console.warn('Illegal value from weekChange event: ' + event) }
      this.day = addDays(this.day, offset)
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
