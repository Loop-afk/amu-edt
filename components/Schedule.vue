<template>
  <div :style="{height: scheduleHeight}">
    <div>{{ hello }}</div>
    <div class="schedule-row">
      <div v-for="day in scheduleSettingsGetWeekDays()" :key="day.id" class="schedule-row-child box">
        <schedule-day :schedule-day-settings-date="day" :schedule-schedule="scheduleParseSchedule(scheduleSchedule, day)" />
      </div>
    </div>
  </div>
</template>

<script>
import ScheduleDay from '~/components/Schedule/ScheduleDay.vue'
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
      type: String,
      default: '800px'
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
    addDays (date, days) { // pris sur internet
      const copy = new Date(Number(date))
      copy.setDate(date.getDate() + days)
      return copy
    },
    scheduleSettingsGetWeekDays () {
      const dayWeek = []
      const currentDate = this.addDays(this.scheduleSettingsDate, -1 * this.scheduleSettingsDate.getDay() + 1)
      for (const dayWeekKey of Array(this.daysOfTheWeek).keys()) { // à changer en profondeur si 5 jours
        const tempDate = this.addDays(currentDate, dayWeekKey)
        dayWeek.push({
          id: dayWeekKey,
          dayString: this.capitalizeFirstLetter(
            tempDate.toLocaleDateString('fr-fr', { weekday: 'long' })),
          isToday: (this.scheduleSettingsDate.getDay() - 1 === dayWeekKey),
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
