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
import { getComparableFromDate, compareComparableDate } from '~/assets/js/comparableDate.js'
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
          end: 22
        },
        data: [
          {
            day: { month: 5, day: 4, year: 2021 },
            groups: [{ id: 1, value: 'L3 info' }],
            start: {
              hours: 7,
              minutes: 45
            },
            end: {
              hours: 10,
              minutes: 0
            },
            ue: {
              field: { id: 1, value: 'Fourth Event' },
              date: {
                year: 2020,
                semester: 0
              }
            },
            teacher: { id: 1, value: 'Nobody.' },
            place: {
              room: { id: 1, value: 'Home' },
              campus: { id: 1, value: 'Luminy' }
            }
          },
          {
            day: { month: 4, day: 6, year: 2021 },
            groups: [{ id: 1, value: 'L3 info' }],
            start: {
              hours: 6,
              minutes: 0
            },
            end: {
              hours: 28,
              minutes: 0
            },
            ue: {
              field: { id: 1, value: 'Third Event' },
              date: {
                year: 2020,
                semester: 0
              }
            },
            teacher: { id: 1, value: 'Nobody.' },
            place: {
              room: { id: 1, value: 'Home' },
              campus: { id: 1, value: 'Luminy' }
            }
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
      // console.log(this.scheduleSettingsDate, -1 * this.scheduleSettingsDate.getDay() + 1)
      const weekDate = addDays(this.scheduleSettingsDate, -1 * this.scheduleSettingsDate.getDay() + 1)
      for (const dayWeekKey of Array(this.daysOfTheWeek).keys()) {
        const tempDate = addDays(weekDate, dayWeekKey)
        console.log(weekDate, dayWeekKey, tempDate)
        dayWeek.push(tempDate)
      }
      console.table(dayWeek)
      return dayWeek
    },
    scheduleParseSchedule (schedule, day) { // permet d'envoyer seulement les cours du jour au composant ScheduleDay
      const comparableDay = getComparableFromDate(day)
      console.log(comparableDay)
      const a = schedule.data.filter(course => compareComparableDate(course.day, comparableDay))
      let b = a.filter(course => this.scheduleDisplayedGroups.some(eachGroup => course.groups.some(courseAllowed => courseAllowed.id === eachGroup)) === true)
      // console.log(b)
      // console.log('---')
      if (b.length === 0) {
        b = null
      }
      return { data: b, workingHours: schedule.workingHours } // attention avant chaque modification de data
    },
    isDateToday (date) {
      const today = new Date()
      if (compareComparableDate(getComparableFromDate(today), getComparableFromDate(date))) { return true }
      return false
    },
    getFormatedWeekDay (date) {
      const dateString = date.toLocaleDateString('fr-fr', { weekday: 'long', day: 'numeric' })
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
