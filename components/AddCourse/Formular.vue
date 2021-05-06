<template>
  <div>
    <form>
      <input v-model="formular.title" placeholder="Matière du cours">
      <div class="debug">
        {{ formular }}
      </div>
    </form>
  </div>
</template>

<script>
export default {
  data () {
    return {
      formular: {
        title: null,
        day: null,
        occurences: null,
        groups: [],
        start: { hour: null, minutes: null },
        end: { hour: null, minutes: null },
        teacher: null,
        room: null
      }
    }
  }
}
</script>

<style scoped>

</style>
