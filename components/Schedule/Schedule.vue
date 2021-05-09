<template>
  <div :style="{height: scheduleHeight + 'px'}">
    <ordinate-line
      :working-hours="scheduleSchedule.workingHours"
      :schedule-height="scheduleHeight"
      style="position: absolute; top: 37px;"
    />
    <div class="schedule-row">
      <div style="position: absolute; width: 100%; display: flex; top: 0px;" class="box">
        <div
          v-for="(day, key) in generateWeekDays(scheduleReferenceDate, daysOfTheWeek)"
          :key="key"
          :style="{width: (100/lenWeekDays())+'%'}"
          :class="{scheduleToday: isDateSame(day, new Date()),
                   scheduleReferenceDate: isDateSame(day, addDays(scheduleReferenceDate, 1))}"
          class="scheduleHeaderDate box"
        >
          {{ getFormatedWeekDay(day) }}
        </div>
      </div>
      <div style="position: absolute; width: 100%; display: flex; top: 37px;">
        <ordinate-axis
          style="left: -20px; top: -12px; position: absolute;"
          :working-hours="scheduleSchedule.workingHours"
          :schedule-height="scheduleHeight"
        />
        <div v-for="(day, key) in generateWeekDays(scheduleReferenceDate, daysOfTheWeek)" :key="key" style="width: 100%;">
          <schedule-day
            :schedule-reference-date="scheduleReferenceDate"
            :schedule-schedule="scheduleParseSchedule(scheduleSchedule, day, scheduleDisplayedGroups)"
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
    scheduleReferenceDate: {
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
    },
    daysOfTheWeek: {
      type: Number,
      default: 7
    }
  },
  data () {
    return {
      OrdinateAxisOffset: -30,
      scheduleSchedule: {
        workingHours: {
          start: 4,
          end: 22
        },
        data: [
          {
            day: { day: 4, month: 5, year: 2021 },
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
            day: { day: 6, month: 5, year: 2021 },
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
    scheduleSettingsGetWeekDays (daysDisplayed, scheduleReferenceDate) {
      const dayWeek = []
      let weekDate = addDays(scheduleReferenceDate, -1 * scheduleReferenceDate.getDay() + 1)
      if ((Math.abs(scheduleReferenceDate - weekDate) / (1000 * 3600 * 24)) >= daysDisplayed) { weekDate = scheduleReferenceDate }
      for (const dayWeekKey of Array(daysDisplayed).keys()) {
        const tempDate = addDays(weekDate, dayWeekKey)
        dayWeek.push(tempDate)
      }
      return dayWeek
    },
    // todo supprimer et remplaer par requete REST
    scheduleParseSchedule (schedule, day, scheduleDisplayedGroups) { // permet d'envoyer seulement les cours du jour au composant ScheduleDay
      const comparableDay = getComparableFromDate(day)
      const a = schedule.data.filter(course => compareComparableDate(course.day, comparableDay))
      let b = a.filter(course => scheduleDisplayedGroups.some(eachGroup => course.groups.some(courseAllowed => courseAllowed.id === eachGroup)) === true)
      if (b.length === 0) {
        b = null
      }
      return { data: b, workingHours: schedule.workingHours } // attention avant chaque modification de data
    },
    isDateSame (date1, date2) {
      if (compareComparableDate(getComparableFromDate(date2), getComparableFromDate(date1))) { return true }
      return false
    },
    getFormatedWeekDay (date) {
      return this.capitalizeFirstLetter(date.toLocaleDateString('fr-fr', { weekday: 'long', day: 'numeric' }))
    },
    capitalizeFirstLetter (word) {
      return word.charAt(0).toUpperCase() + word.slice(1)
    },
    lenWeekDays () {
      return lenWeekDays()
    },
    addDays (date, days) {
      return addDays(date, days)
    },
    generateWeekDays (date, days) {
      let weekDays = getWeekDays(date, days)
      if (weekDays != null) { return weekDays }
      weekDays = this.scheduleSettingsGetWeekDays(days, date)
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

.scheduleReferenceDate {
  color:brown;
}

.schedule-row-child {
  width: 100%;
}
</style>
