<template>
  <div>
    <div @click="weekChange(-7)">
      <b-icon-arrow-left id="tooltip-navigator-week-left" />
      <b-tooltip target="tooltip-navigator-week-left" triggers="hover" placement="right">
        Revenir d'une semaine en arrière
      </b-tooltip>
    </div>
    <div @click="weekChange(7)">
      <b-icon-arrow-right id="tooltip-navigator-week-right" />
      <b-tooltip target="tooltip-navigator-week-right" triggers="hover" placement="right">
        Avancer d'une semaine
      </b-tooltip>
    </div>
    <div @click="weekChange(-1)">
      <b-icon-arrow-left-short id="tooltip-navigator-day-left" />
      <b-tooltip target="tooltip-navigator-day-left" triggers="hover" placement="right">
        Revenir d'un jour en arrière
      </b-tooltip>
    </div>
    <div @click="weekChange(1)">
      <b-icon-arrow-right-short id="tooltip-navigator-day-right" />
      <b-tooltip target="tooltip-navigator-day-right" triggers="hover" placement="right">
        Avancer d'un jour
      </b-tooltip>
    </div>
  </div>
</template>

<script>
import { BIconArrowRight, BIconArrowRightShort, BIconArrowLeft, BIconArrowLeftShort } from 'bootstrap-vue'

export default {
  components: {
    BIconArrowRight, BIconArrowRightShort, BIconArrowLeft, BIconArrowLeftShort
  },
  methods: {
    weekChange (jump) {
      this.$emit('weekChangeEvent', jump)
    }
  }
}
</script>

<style scoped>

</style>
