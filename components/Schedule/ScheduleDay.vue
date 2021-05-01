<template>
  <div style="height: 100%">
    <!--{{ day.id }} - {{ day.dayString }} - {{ day.isToday }} - {{ day.dayExact }} -->
    <span :class="{scheduleToday: scheduleDaySettingsDate.isToday}" style="position: relative;">
      {{ scheduleDaySettingsDate.dayString + ' ' + scheduleDaySettingsDate.dayDay }}
    </span>
    <!-- container day appointments -->
    <div style="height: 100%; position: relative;">
      <div v-for="(course, key) in scheduleSchedule.data" :key="key" class="appointment">
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
    }
  },
  data () {
    return {

    }
  },
  methods: {
    scheduleSetHeightFromDate (date) {
      return 100
    }
  }
}
</script>

<style>
.scheduleToday {
  color: blue;
}

.appointment {
    box-shadow: 0px 0px 0px 1px rgb(53, 139, 72);
    position: absolute;
    top: 0px;
}
</style>
