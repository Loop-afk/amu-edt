<template>
  <div>
    <form>
      <label>Matière</label>
      <b-form-input v-model="formular.title" type="text" list="list_title" placeholder="Matière du cours" />
      <b-form-datalist id="list_title" :options="formular_options.title" />
      <b-form-input v-model="formular.day" type="date" />
      <b-form-input v-model="startTime" type="time" />
      <b-form-input v-model="endTime" type="time" />
      <b-form-input v-model="formular.teacher" type="text" list="list_teacher" placeholder="Professeur" />
      <b-form-datalist id="list_teacher" :options="formular_options.teacher" />

      <!--
      -->
      <br>
      <br>
      <br>
      <br>
      <div class="debug">
        {{ endTime }}
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
      },
      test: '',

      formular_options: {
        title: ['Algorithmique', 'Logique', 'Projet'],
        teacher: ['Line JAMET JAKUBIEC', 'Victor CEPOI', 'Séverine Fratanie'],
        groups: [1, 2, 3]

      }
    }
  },
  computed: {
    startTime: { // overide
      get () {
        return this.formular.start.hour + ':' + this.formular.start.minutes
      },
      set (value) {
        const temp = value.split(':')
        this.formular.start.hour = temp[0]
        this.formular.start.minutes = temp[1]
      }
    },
    endTime: { // overide
      get () {
        return this.formular.end.hour + ':' + this.formular.end.minutes
      },
      set (value) {
        const temp = value.split(':')
        this.formular.end.hour = temp[0]
        this.formular.end.minutes = temp[1]
      }
    }
  },
  methods: { }
}
</script>

<style scoped>

</style>
