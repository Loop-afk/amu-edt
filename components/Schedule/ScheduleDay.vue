<template>
  <div style="height: 100%; width: 100%; position: relative">
    <div class="scheduleDayContainer" style="width: 100%">
      <div
        v-for="(course, key) in parsedSchedule"
        :id="'course-target-'+generateTargetId()"
        :key="key"
        class="scheduleCourse cScheduleCourse"
        :style="getCourseStyle(course)"
        @click="courseClicked(course)"
      >
        <div class="scheduleCourseUe cScheduleCourseUe">
          {{ course.ue.field.value }}
        </div>
        <div class="scheduleCourseDate cScheduleCourseDate">
          {{ getFormatedHoursMinutes(course.start) + '-' + getFormatedHoursMinutes(course.end) }}
        </div>
        <b-popover
          :target="'course-target-'+getTargetId()"
          :triggers="['hover']"
          placement="right"
          delay="0"
        >
          <p>Salle de classe {{ course.place.room.value }}</p>
          <p>Professeur {{ course.teacher.value }}</p>
          <p>Date du cours {{ getReFormatedDate(course.date) }}</p>
        </b-popover>
      </div>
    </div>
  </div>
</template>

<script>
import { generateTargetId, getTargetId } from '~/assets/js/targetId.js'
import { getInputFormatedDate, getReFormatedDate, getFormatedHoursMinutes } from '~/assets/js/formatedDate.js'
export default {
  props: {
    parsedSchedule: {
      default: null,
      type: Array
    },
    scheduleHeight: {
      type: Number,
      required: true
    },
    workingHours: {
      type: Object,
      required: true
    },
    allowCourseClickEvent: {
      type: Boolean,
      required: true
    }
  },
  data () {
    return { }
  },
  methods: {
    scheduleGetHeightFromDate (course) {
      const unit = this.scheduleHeight / (this.workingHours.end - this.workingHours.start)
      const height = (unit * (course.end.hours - course.start.hours) + (unit * (course.end.minutes - course.start.minutes) / 60))
      if (height > this.scheduleHeight) { return (unit * (this.workingHours.end - this.workingHours.start)) + 'px' } // - 2 totalement faux
      return height + 'px'
    },
    scheduleGetTopFromDate (course) {
      const unit = this.scheduleHeight / (this.workingHours.end - this.workingHours.start)
      const top = (unit * (course.start.hours - this.workingHours.start)) + (unit * (course.start.minutes / 60))
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
    },
    getReFormatedDate (date) {
      return getReFormatedDate(date)
    },
    getFormatedHoursMinutes (time) {
      return getFormatedHoursMinutes(time)
    },
    getInputFormatedDate (date) {
      getInputFormatedDate(date)
    },
    courseClicked (course) {
      if (this.allowCourseClickEvent) { this.$emit('courseClickedEvent', course) }
    }
  }
}
</script>

<style scoped>

.scheduleDayContainer {
  height: 100%;
  position: relative;
}

.scheduleCourse{
  position: absolute;
  top: 0px;
  word-wrap: break-word;
  width: 100%;
  z-index: 10;
}

.scheduleCourseDate {
  text-align: center;
}

.scheduleCourseUe {
  text-align: center;
}
</style>
