<template>
  <div :style="{height: scheduleHeight + 'px'}">
    <div>{{ hello }}</div>
    <div class="schedule-row">
      <!-- scheduleSettingsGetWeekDays exécuté 7 fois (à corriger) + width à bind -->
      <div v-for="day in scheduleSettingsGetWeekDays()" :key="day.id" class="schedule-row-child box" style="width: 15%">
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
      hello: 'hello world',
      daysOfTheWeek: 7
    }
  },
  beforeMount () {

  },
  mounted () {

  },
  methods: {
    capitalizeFirstLetter (word) {
      return word.charAt(0).toUpperCase() + word.slice(1)
    },
    scheduleSettingsGetWeekDays () {
      const dayWeek = []
      const weekDate = addDays(this.scheduleSettingsDate, -1 * this.scheduleSettingsDate.getDay() + 1)
      for (const dayWeekKey of Array(this.daysOfTheWeek).keys()) {
        const tempDate = addDays(weekDate, dayWeekKey)
        dayWeek.push({
          id: dayWeekKey,
          dayString: this.capitalizeFirstLetter(
            tempDate.toLocaleDateString('fr-fr', { weekday: 'long' })),
          isToday: (this.scheduleSettingsDate.toLocaleDateString('fr-fr', { day: 'numeric', month: 'numeric', year: 'numeric' }) ===
            tempDate.toLocaleDateString('fr-fr', { day: 'numeric', month: 'numeric', year: 'numeric' })),
          dayExact: tempDate.toLocaleDateString('fr-fr'),
          dayDay: tempDate.toLocaleDateString('fr-fr', { day: 'numeric' })
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
