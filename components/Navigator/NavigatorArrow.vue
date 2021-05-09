<template>
  <div>
    <div @click="weekChange(-7)">
      #week ago#
    </div>
    <div @click="weekChange(7)">
      #next week#
    </div>
    <div @click="weekChange(-1)">
      #day ago#
    </div>
    <div @click="weekChange(1)">
      #next day#
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    weekChange (jump) {
      this.$emit('weekChangeEvent', jump)
    }
  }
}
</script>

<style scoped>

</style>
