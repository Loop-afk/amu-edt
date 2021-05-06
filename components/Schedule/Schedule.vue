<template>
  <div :style="{height: scheduleHeight + 'px'}">
    <ordinate-line
      :working-hours="scheduleSchedule.workingHours"
      :schedule-height="scheduleHeight"
      style="position: absolute;"
    />
    <div class="schedule-row">
      <div style="position: absolute; width: 100%; display: flex;" class="box">
        <div v-for="(day, key) in generateWeekDays(scheduleSettingsDate)" :key="key" :style="{width: (100/lenWeekDays())+'%'}" :class="{scheduleToday: isDateToday(day)}" class="scheduleHeaderDate box">
          {{ getFormatedWeekDay(day) }}
        </div>
      </div>
      <div style="position: absolute; width: 100%; display: flex; top: 70px;">
        <ordinate-axis
          style="left: -20px; top: -20px; position: absolute;"
          :working-hours="scheduleSchedule.workingHours"
          :schedule-height="scheduleHeight"
        />
        <div v-for="(day, key) in generateWeekDays(scheduleSettingsDate)" :key="key" style="width: 100%;">
          <schedule-day
            :schedule-schedule="scheduleParseSchedule(scheduleSchedule, day)"
            :schedule-height="scheduleHeight"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import ScheduleDay from '~/components/Schedule/ScheduleDay.vue'
import addDays from '~/assets/js/addDays.js'
import OrdinateAxis from '~/components/Schedule/OrdinateAxis.vue'
import { getWeekDays, setWeekDays, lenWeekDays } from '~/assets/js/weekDays.js'
import OrdinateLine from '~/components/Schedule/OrdinateLine.vue'
export default {
  components: {
    ScheduleDay, OrdinateAxis, OrdinateLine
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
    scheduleDisplayedGroups: {
      type: Array,
      default: () => [],
      required: false
    }
  },
  data () {
    return {
      daysOfTheWeek: 7,
      scheduleSchedule: {
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
    },
    lenWeekDays () {
      return lenWeekDays()
    },
    generateWeekDays (date) {
      let weekDays = getWeekDays(date)
      if (weekDays != null) { return weekDays }
      weekDays = this.scheduleSettingsGetWeekDays()
      setWeekDays(weekDays)
      return weekDays
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
  flex-direction: row;
  position: relative;
  word-wrap: break-word;
}

.scheduleToday {
  color: blue;
}

.schedule-row-child {
  width: 100%;
}
</style>
