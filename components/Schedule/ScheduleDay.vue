<template>
  <div style="height: 100%">
    <!--{{ day.id }} - {{ day.dayString }} - {{ day.isToday }} - {{ day.dayExact }} -->
    <span v-if="scheduleDaySettingsDate.isToday === true" class="schedule-today">
      {{ scheduleDaySettingsDate.dayString + ' ' + scheduleDaySettingsDate.dayDay }}
    </span>
    <span v-else>
      {{ scheduleDaySettingsDate.dayString + ' ' + scheduleDaySettingsDate.dayDay }}
    </span>
    <div v-for="course in scheduleSchedule.data" :key="course.id">
      {{ course.title }}
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
    }
  },
  data () {
    return {

    }
  }
}
</script>

<style>
.schedule-today {
  color: blue;
}

</style>
