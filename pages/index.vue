<template>
  <div>
    <b-container>
      <!-- todo enlever marge -->
      <b-row>
        <b-col cols="4" class="box">
          <list-groups />
          <navigator-arrow @weekChangeEvent="weekChange($event)" />
        </b-col>
        <b-col cols="8" class="box">
          <schedule
            :schedule-settings-date="day"
            :schedule-schedule="schedule"
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
export default {
  components: {
    ListGroups,
    Schedule,
    NavigatorArrow
  },
  data () {
    return {
      day: new Date()
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
            day: '01/05/2021', // todo ? virer ça dans l'objet (et pas dans l'array)
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
            day: '01/05/2021',
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
            day: '02/05/2021',
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
            day: '05/05/2021',
            start: {
              hours: 8,
              minutes: 45
            },
            end: {
              hours: 10,
              minutes: 0
            },
            title: 'Third Event',
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
      if (event === 'right') { offset = 7 } else if (event === 'left') { offset = -7 } else { console.warn('Illegal value from event: ' + event) }
      this.day = addDays(this.day, offset)
    }
  }
}
</script>

<style scoped>
</style>
