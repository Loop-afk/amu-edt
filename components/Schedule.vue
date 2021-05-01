<template>
  <div :style="{height: scheduleHeight + 'px'}">
    <div class="schedule-row">
      <!-- scheduleSettingsGetWeekDays exécuté 7 fois (à corriger) + width à bind -->
      <div v-for="day in scheduleSettingsGetWeekDays()" :key="day.id" class="schedule-row-child box" style="width: 14%">
        <schedule-day
          :schedule-day-settings-date="day"
          :schedule-schedule="scheduleParseSchedule(scheduleSchedule, day)"
          :schedule-height="scheduleHeight"
        />
      </div>
    </div>
  </div>
</template>

<script>
import ScheduleDay from '~/components/Schedule/ScheduleDay.vue'
import addDays from '~/assets/js/addDays.js'
export default {
  components: {
    ScheduleDay
  },
  props: {
    scheduleSettingsDate: {
      type: Date,
      required: true
    },
    scheduleHeight: {
      type: Number,
      default: 800
    },
    scheduleSchedule: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      daysOfTheWeek: 7
    }
  },
  beforeMount () {

  },
  mounted () {

  },
  methods: {
    scheduleSettingsGetWeekDays () {
      const dayWeek = []
      const weekDate = addDays(this.scheduleSettingsDate, -1 * this.scheduleSettingsDate.getDay() + 1)
      for (const dayWeekKey of Array(this.daysOfTheWeek).keys()) {
        const tempDate = addDays(weekDate, dayWeekKey)
        dayWeek.push({
          date: tempDate
        })
      }
      return dayWeek
    },
    scheduleParseSchedule (schedule, day) {
      return schedule
    }
  }
}
</script>

<style scoped>
.box{
  box-shadow: 0px 0px 0px 1px rgb(255, 71, 71);
}

.schedule-row {
  display: flex;
  flex-flow: row;
  text-align: center;
}

.schedule-row-child {
  width: 100%;
}
</style>
