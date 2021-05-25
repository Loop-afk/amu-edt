<template>
  <div :style="{height: scheduleHeight + 'px', top: -1 * OrdinateAxisOffset + 20 + 'px'}">
    <ordinate-line
      :working-hours="workingHours"
      :schedule-height="scheduleHeight"
      style="position: absolute; top: 37px;"
    />
    <div class="schedule-row">
      <div style="position: absolute; width: 100%; display: flex; top: -23px; ">
        <div
          v-for="(day, key) in scheduleSettingsGetWeekDays (displayedDays, scheduleReferenceDate)"
          :key="key"
          :style="{width: (100/displayedDays)+'%'}"
          class="scheduleHeader textDark"
        >
          <p class="backGroundLightDark">
            <span
              class="scheduleHeaderDate"
              :class="{
                textEmphasize: isDateSame(day, scheduleReferenceDate),
                textMain: isDateSame(day, new Date())}"
            > <!-- click pour changer reference date -->
              {{ day.toLocaleDateString('fr-fr', { day: 'numeric' }) }}
            </span>
            <br>
            <span class="scheduleHeaderDateSub">
              {{ capitalizeFirstLetter(day.toLocaleDateString('fr-fr', { weekday: 'long' })) }}
            </span>
          </p>
          <div
            style="position: relative; top: -20px;"
            :style="{height: scheduleHeight + 80 + 'px'}"
            class="clineVertical"
          />
        </div>
      </div>
      <div style="position: absolute; width: 100%; display: flex; top: 38px;">
        <ordinate-axis
          style="left: -14px; top: -12px; position: absolute;"
          :working-hours="workingHours"
          :schedule-height="scheduleHeight"
        />
        <div v-for="(day, key) in scheduleSettingsGetWeekDays (displayedDays, scheduleReferenceDate)" :key="key" style="width: 100%;">
          <schedule-day
            :schedule-reference-date="scheduleReferenceDate"
            :parsed-schedule="parseSchedule(schedule, day, scheduleDisplayedGroups)"
            :schedule-height="scheduleHeight"
            :working-hours="workingHours"
            :allow-course-click-event="allowCourseClickEvent"
            @courseClickedEvent="courseChange($event)"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import addDays from '~/assets/js/addDays.js'
import OrdinateAxis from '~/components/Schedule/OrdinateAxis.vue'
import { getComparableFromDate, compareComparableDate } from '~/assets/js/comparableDate.js'
import OrdinateLine from '~/components/Schedule/OrdinateLine.vue'
import { schedulePush, scheduleGet, schedulePrepareRequest } from '~/assets/js/schedule.js'

export default {
  components: {
    OrdinateAxis, OrdinateLine
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
    displayedDays: {
      type: Number,
      default: 7
    },
    allowCourseClickEvent: {
      type: Boolean,
      default: true
    }
  },
  data () {
    return {
      OrdinateAxisOffset: -30,
      workingHours: { start: 6, end: 20 },
      schedule: [],
      weekDays: []
    }
  },
  watch: {
    async scheduleReferenceDate (newScheduleReferenceDate) {
      this.schedule = await this.getSchedule(this.scheduleSettingsGetWeekDays(this.displayedDays, newScheduleReferenceDate), this.scheduleDisplayedGroups)
    },
    async scheduleDisplayedGroups (newscheduleDisplayedGroups) {
      this.schedule = await this.getSchedule(this.scheduleSettingsGetWeekDays(this.displayedDays, this.scheduleReferenceDate), newscheduleDisplayedGroups)
    }
  },
  mounted () {
    this.scheduleRefresh()
  },
  methods: {
    async scheduleRefresh () {
      this.schedule = await this.getSchedule(this.scheduleSettingsGetWeekDays(this.displayedDays, this.scheduleReferenceDate), this.scheduleDisplayedGroups, true)
    },
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
    parseSchedule (schedule, day) { // permet d'envoyer seulement les cours du jour au composant ScheduleDay
      const comparableDay = getComparableFromDate(day)
      let dayFiltered = schedule.filter(course => compareComparableDate(course.date, comparableDay))
      if (dayFiltered.length === 0) {
        dayFiltered = null
      }
      return dayFiltered
    },
    isDateSame (date1, date2) {
      if (compareComparableDate(getComparableFromDate(date2), getComparableFromDate(date1))) { return true }
      return false
    },
    capitalizeFirstLetter (word) {
      return word.charAt(0).toUpperCase() + word.slice(1)
    },
    addDays (date, days) {
      return addDays(date, days)
    },
    courseChange (event) {
      this.$emit('courseClickedEvent', event)
    },
    fetchSchedule (request) {
      return fetch(request)
        .then(res => res.json())
        .then((data) => { return data })
        .catch((error) => {
          this.$bvToast.toast(`Une erreur s'est produite lors de la réception des données de l'agenda
          Description: ${error}`, {
            title: 'Une erreur est survenue',
            autoHideDelay: 10000,
            variant: 'danger',
            appendToast: false
          })
        })
    },
    async getSchedule (weekDays, scheduleDisplayedGroups, force = false) {
      const req = schedulePrepareRequest(weekDays, scheduleDisplayedGroups, force)
      if (req !== null) { schedulePush(await this.fetchSchedule(req)) }
      return scheduleGet(weekDays, scheduleDisplayedGroups)
    }
  }
}
</script>

<style scoped>
.schedule-row {
  display: flex;
  flex-flow: row;
  text-align: center;
}

.scheduleHeaderDate {
  font-size: 1.5em;
  font-weight: 600;
}

.scheduleHeaderDateSub {
  font-size: 0.8em;
}

.scheduleHeader {
  font-family: 'Open sans';
}

.schedule-row-child {
  width: 100%;
}

.scheduleCorrectPadding {
  padding: 0px;
}
</style>
