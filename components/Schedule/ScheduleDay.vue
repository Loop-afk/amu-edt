<template>
  <div style="height: 100%; width: 100%; position: relative">
    <div class="scheduleDayContainer" style="width: 100%">
      <div v-if="scheduleSchedule != null ">
        <div
          v-for="(course, key) in scheduleSchedule.data"
          :id="'course-target-'+generateTargetId()"
          :key="key"
          class="scheduleCourse"
          :style="getCourseStyle(course)"
          @click="courseClicked(course)"
        >
          <div class="scheduleCourseMessage">
            {{ course.ue.field.value }}
            <br>
            {{ getReFormatedDate(course.day) }}
          </div>
          <b-popover
            :target="'course-target-'+getTargetId()"
            :triggers="['hover']"
            placement="right"
            delay="0"
          >
            {{ course.place.room.value + ' ' + course.teacher.value }}
            <br>
            {{ getInputFormatedDate(new Date({day:course.day, month: course.month, year: course.year})) }}
          </b-popover>
          {{ course.title }}
        </div>
      </div>
      <div v-else>
        Internal Error 500#1
      </div>
    </div>
  </div>
</template>

<script>
import { generateTargetId, getTargetId } from '~/assets/js/targetId.js'
import { getInputFormatedDate, getReFormatedDate } from '~/assets/js/formatedDate.js'
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
    return { }
  },
  methods: {
    scheduleGetHeightFromDate (course) {
      const unit = this.scheduleHeight / (this.scheduleSchedule.workingHours.end - this.scheduleSchedule.workingHours.start)
      const height = (unit * (course.end.hours - course.start.hours) + (unit * (course.end.minutes - course.start.minutes) / 60))
      if (height > this.scheduleHeight) { return (unit * (this.scheduleSchedule.workingHours.end - this.scheduleSchedule.workingHours.start - 2)) + 'px' } // - 2 totalement faux
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
    },
    getReFormatedDate (date) {
      return getReFormatedDate(date)
    },
    getInputFormatedDate (date) {
      getInputFormatedDate(date)
    },
    courseClicked (course) {
      this.$emit('courseClickedEvent', course)
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
  box-shadow: 0px 0px 0px 1px rgb(53, 139, 72);
  position: absolute;
  top: 0px;
  word-wrap: break-word;
  width: 100%;
  background-color: aqua;
  z-index: 10;
}

.scheduleCourseMessage {
  text-align: center;
}
</style>
