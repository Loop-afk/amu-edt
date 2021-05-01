<template>
  <div style="height: 100%">
    <span :class="{scheduleToday: isDateToday(scheduleDaySettingsDate.date)}" style="position: relative;" class="scheduleHeaderDate">
      {{ this.getFormatedDay(scheduleDaySettingsDate.date) }}
    </span>
    <!-- container for day appointments -->
    <div style="height: 100%; position: relative;">
      <div v-for="(course, key) in scheduleSchedule.data" :key="key" class="scheduleCourse" :style="{top: scheduleSetHeightFromDate(course)}">
        {{ course.title }}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    scheduleDaySettingsDate: {
      type: Object,
      required: true
    },
    scheduleSchedule: {
      type: Object,
      default: null,
      required: false
    },
    scheduleHeight: {
      type: Number,
      required: true
    }
  },
  data () {
    return {

    }
  },
  methods: {
    capitalizeFirstLetter (word) {
      return word.charAt(0).toUpperCase() + word.slice(1)
    },
    getFormatedDay (date) {
      const dateString = date.toLocaleDateString('fr-fr', { weekday: 'long', day: 'numeric' })
      return this.capitalizeFirstLetter(dateString)
    },
    scheduleSetHeightFromDate (course) {
      const unit = this.scheduleHeight / (this.scheduleSchedule.workingHours.end - this.scheduleSchedule.workingHours.start)
      const top = (unit * (course.start.getHours() - this.scheduleSchedule.workingHours.start)) + (unit * (course.start.getMinutes() / 60))
      // console.table([unit, top])
      return top + 'px'
    },
    isDateToday (date) {
      const today = new Date()
      if (today.toLocaleDateString('fr-fr', { day: 'numeric', month: 'numeric', year: 'numeric' }) === date.toLocaleDateString('fr-fr', { day: 'numeric', month: 'numeric', year: 'numeric' })) { return true }
      return false
    }
  }
}
</script>

<style>
.scheduleToday {
  color: blue;
}

.scheduleHeaderDate{
  font-style: italic;
}

.scheduleCourse{
  box-shadow: 0px 0px 0px 1px rgb(53, 139, 72);
    position: absolute;
    top: 0px;
}
</style>
