<template>
  <div style="height: 100%">
    <!--{{ day.id }} - {{ day.dayString }} - {{ day.isToday }} - {{ day.dayExact }} -->
    <span :class="{scheduleToday: scheduleDaySettingsDate.isToday}" style="position: relative;" class="scheduleHeaderDate">
      {{ scheduleDaySettingsDate.dayString + ' ' + scheduleDaySettingsDate.dayDay }}
    </span>
    <!-- container day appointments -->
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
    scheduleSetHeightFromDate (course) {
      const unit = this.scheduleHeight / (this.scheduleSchedule.workingHours.end - this.scheduleSchedule.workingHours.start)
      const top = (unit * (course.start.getHours() - this.scheduleSchedule.workingHours.start)) + (unit * (course.start.getMinutes() / 60))
      // console.table([unit, top])
      return top + 'px'
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
