<template>
  <div>
    <div @click="weekChangeLeft()">
      #go left#
    </div>
    <div @click="weekChangeRight()">
      #go right#
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    weekChangeLeft () {
      this.$emit('weekChangeEvent', 'left')
    },
    weekChangeRight () {
      this.$emit('weekChangeEvent', 'right')
    }
  }
}
</script>

<style scoped>

</style>
