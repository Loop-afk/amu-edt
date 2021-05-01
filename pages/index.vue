<template>
  <div>
    <b-container>
      <b-row>
        <b-col cols="4" class="box">
          <list-groups />
        </b-col>
        <b-col cols="8" class="box">
          <schedule :schedule-settings-date="day" :schedule-schedule="schedule" :schedule-height="600" />
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import ListGroups from '~/components/ListGroups.vue'
import Schedule from '~/components/Schedule.vue'
export default {
  components: {
    ListGroups, Schedule
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
            start: new Date(2020, 5, 1, 15, 15),
            end: new Date(2020, 5, 1, 17, 15),
            title: 'First Event Ever!',
            teacher: 'Nobody :(',
            room: 'Home'
          }
        ]
      }
    }
  }
}
</script>

<style scoped>
</style>
