<template>
  <div :style="{height: scheduleHeight + 'px'}">
    <div class="schedule-row">
      <ordinate-axis
        :style="{height: scheduleHeight}"
        style="width: 12.5%; position: absolute; left: 0px"
        :working-hours="scheduleSchedule.workingHours"
        :schedule-height="scheduleHeight"
      />
      <!-- scheduleSettingsGetWeekDays exécuté 7 fois (à corriger) + width à bind + day.id à remove -->
      <div style="position: absolute; width: 100%; display: flex;">
        <div v-for="(day, key) in scheduleSettingsGetWeekDays()" :key="key" :class="{scheduleToday: isDateToday(day)}" style="flex-direction: row; position: relative;width: 12.5%;   word-wrap: break-word;" class="scheduleHeaderDate">
          {{ getFormatedWeekDay(day) }}
        </div>
      </div>
      <div v-for="day in scheduleSettingsGetWeekDays()" :key="day.id" class="schedule-row-child" style="width: 12.5%">
        <schedule-day
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
import OrdinateAxis from '~/components/Schedule/OrdinateAxis.vue'
export default {
  components: {
    ScheduleDay, OrdinateAxis
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
    },
    scheduleDisplayedGroups: {
      type: Array,
      default: () => [],
      required: false
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
          date: tempDate,
          day: tempDate.toLocaleDateString('fr-fr', { day: 'numeric', month: 'numeric', year: 'numeric' })
        })
      }
      return dayWeek
    },
    scheduleParseSchedule (schedule, day) { // permet d'envoyer seulement les cours du jour au composant ScheduleDay
      const a = schedule.data.filter(course => course.day === day.day)
      const b = a.filter(course => this.scheduleDisplayedGroups.some(eachGroup => course.group.includes(eachGroup)) === true)
      // const b = a.filter(course => course.group.some(courseGroup => this.scheduleDisplayedGroups.includes(courseGroup)) === true)
      return { data: b, workingHours: schedule.workingHours }
    },
    isDateToday (date) {
      const today = new Date()
      if (today.toLocaleDateString('fr-fr', { day: 'numeric', month: 'numeric', year: 'numeric' }) === date.day) { return true }
      return false
    },
    getFormatedWeekDay (date) {
      const dateString = date.date.toLocaleDateString('fr-fr', { weekday: 'long', day: 'numeric' })
      return this.capitalizeFirstLetter(dateString)
    },
    capitalizeFirstLetter (word) {
      return word.charAt(0).toUpperCase() + word.slice(1)
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

.scheduleHeaderDate {
  font-style: italic;
}

.schedule-row-child {
  width: 100%;
}
</style>
