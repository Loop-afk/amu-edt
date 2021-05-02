<template>
  <div style="height: 100%">
    <div class="scheduleDayContainer">
      <div
        v-for="(course, key) in scheduleSchedule.data"
        :id="'course-target-'+generateTargetId()"
        :key="key"
        class="scheduleCourse"
        :style="getCourseStyle(course)"
      >
        <b-popover
          :target="'course-target-'+getTargetId()"
          :triggers="['hover']"
          placement="right"
          delay="0"
        >
          {{ course.room + ' ' + course.teacher }}
          <br>
          {{ course.start.hours + 'h' + getFormatedMinutes(course.start.minutes) }}
        </b-popover>
        {{ course.title }}
      </div>
    </div>
  </div>
</template>

<script>
import { generateTargetId, getTargetId } from '~/assets/js/targetId.js'
export default {
  props: {
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
    getFormatedMinutes (minutes) {
      if (minutes < 10) { return '0' + minutes }
      return minutes
    },

    scheduleGetHeightFromDate (course) {
      const unit = this.scheduleHeight / (this.scheduleSchedule.workingHours.end - this.scheduleSchedule.workingHours.start)
      const height = (unit * (course.end.hours - course.start.hours) + (unit * (course.end.minutes - course.start.minutes) / 60))
      if (height > this.scheduleHeight) { return this.scheduleHeight + 'px' }
      return height + 'px'
    },
    scheduleGetTopFromDate (course) {
      const unit = this.scheduleHeight / (this.scheduleSchedule.workingHours.end - this.scheduleSchedule.workingHours.start)
      const top = (unit * (course.start.hours - this.scheduleSchedule.workingHours.start)) + (unit * (course.start.minutes / 60))
      if (top < 0) { return '0px' }
      return top + 'px'
    },
    getCourseStyle (course) { // todo couleur des events
      const top = this.scheduleGetTopFromDate(course)
      return {
        top,
        height: this.scheduleGetHeightFromDate(course),
        display: (parseInt(top) > this.scheduleHeight) ? 'none' : 'block'
      }
    },
    generateTargetId () { // permet d'utiliser les fonctions importés dans la template
      return generateTargetId()
    },
    getTargetId () {
      return getTargetId()
    }
  }
}
</script>

<style>
.scheduleToday {
  color: blue;
}

.scheduleDayContainer {
  height: 100%;
  position: relative;
}

.scheduleCourse{
  box-shadow: 0px 0px 0px 1px rgb(53, 139, 72);
  position: absolute;
  top: 0px;
  word-wrap: break-word;
  width: 100%;
}
</style>
