<template>
  <div>
    <b-container>
      <!-- todo enlever marge -->
      <b-row>
        <b-col cols="2" class="box">
          <list-groups />
          <navigator-arrow @weekChangeEvent="weekChange($event)" />
        </b-col>
        <b-col cols="10" class="box">
          <schedule
            :schedule-settings-date="day"
            :schedule-schedule="schedule"
            :schedule-displayed-groups="scheduleDisplayedGroups"
            :schedule-height="600"
          />
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import ListGroups from '~/components/ListGroups.vue'
import NavigatorArrow from '~/components/Navigator/NavigatorArrow.vue'
import Schedule from '~/components/Schedule.vue'
import addDays from '~/assets/js/addDays.js'
import { clearIdTarget } from '~/assets/js/targetId.js'

export default {
  components: {
    ListGroups,
    Schedule,
    NavigatorArrow
  },
  data () {
    return {
      day: new Date(), // date initiale qu'affiche le schedule
      scheduleDisplayedGroups: [1, 2]
    }
  },
  computed: {
    schedule () {
      return {
        otherProperties: "it's on",
        workingHours: {
          start: 6,
          end: 20
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
            day: '03/05/2021',
            group: [1, 2],
            start: {
              hours: 8,
              minutes: 0
            },
            end: {
              hours: 12,
              minutes: 15
            },
            title: 'Second Event',
            teacher: 'Still Nobody :(',
            room: 'Home'
          },
          {
            day: '04/05/2021',
            group: [1],
            start: {
              hours: 8,
              minutes: 45
            },
            end: {
              hours: 17,
              minutes: 0
            },
            title: 'Third Event',
            teacher: 'Nobody',
            room: 'Home'
          },
          {
            day: '12/05/2021',
            group: [1],
            start: {
              hours: 8,
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
