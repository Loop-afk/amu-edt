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
            day: '01/05/2021', //todo ? virer ça dans l'objet (et pas dans l'array)
            start: new Date(2020, 5, 1, 15, 15),
            end: new Date(2020, 5, 1, 18, 0),
            title: 'First Event Ever!',
            teacher: 'Nobody :(',
            room: 'Home'
          },
          {
            day: '01/05/2021',
            start: new Date(2020, 5, 1, 8, 0),
            end: new Date(2020, 5, 1, 10, 30),
            title: 'Second Event',
            teacher: 'Still Nobody :(',
            room: 'Home'
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
