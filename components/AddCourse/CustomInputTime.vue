<template>
  <div>
    {{ selectedCourseTime }} {{ ' === ' + NewTimeData + ' === ' + NewTime + " === " + test() }}
    <b-form-input :value="test()" type="time" required />
  </div>
</template>

<script>
import { getInputFormatedCustomTime } from '~/assets/js/formatedDate.js'
export default {

  props: {
    selectedCourseTime: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      NewTimeData: null
    }
  },
  computed: {
    NewTime: {
      get () {
        return this.NewTimeData
      },
      set (value) {
        this.NewTimeData = value
      }
    }
  },
  watch: {
    selectedCourseTime: {
      hours: {
        handler: {
          function (newSelectedCourseHours, oldSelectedCourseHours) {
            console.log(newSelectedCourseHours)
            if (newSelectedCourseHours.hours !== undefined) { this.NewTimeData = newSelectedCourseHours.hours + ':' + newSelectedCourseHours.minutes }
          },
          deep: true
        }
      },
      minutes (newSelectedCourseMinutes, oldSelectedCourseMinutes) {
        if (newSelectedCourseMinutes.hours !== undefined) { this.NewTimeData = newSelectedCourseMinutes.hours + ':' + newSelectedCourseMinutes.minutes }
      }
    },
    deep: true
  },
  methods: {
    test () {
      if (this.selectedCourseTime.hours !== undefined && this.selectedCourseTime.minutes !== undefined) { return getInputFormatedCustomTime(this.selectedCourseTime) }
    }
  }
}
</script>
