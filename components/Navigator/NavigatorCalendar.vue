<template>
  <div>
    <b-form-input v-model="scheduleReferenceDateReactive" type="date" />
  </div>
</template>

<script>
import { getInputFormatedDate } from '~/assets/js/formatedDate.js'
export default {
  props: {
    scheduleReferenceDate: {
      type: Date,
      required: true
    }
  },
  computed: {
    scheduleReferenceDateReactive: {
      set (value) {
        this.$emit('calendarDateChangedEvent', new Date(value))
      },
      get () {
        return getInputFormatedDate(this.scheduleReferenceDate)
      }
    }
  },
  methods: {
    getInputFormatedDate (date) {
      return getInputFormatedDate(date)
    }
  }
}
</script>
