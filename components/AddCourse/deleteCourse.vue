<template>
  <b-modal
    id="modal-delete"
    title="Supprimer un cour"
    scrollable
    centered
    @ok="handleSubmit"
  >
    <label>Matière</label>
    <b-form-input v-model="formularNewTitle" type="text" readonly />

    <b-form-input v-model="formularNewTimeStart" type="time" readonly />

    <b-form-input v-model="formularNewTimeEnd" type="time" readonly />

    <!--
    <b-form-input v-model="formularNewOccurence" />
    permet de supprimer les cours suivants
    -->

    <b-form-input v-model="formularNewTeacher" type="text" readonly />

    <b-form-tags v-model="formularNewGroups" tag-pills readonly />

    <b-form-input v-model="formularNewRoom" type="text" readonly />

    <b-form-input v-model="formularNewCampus" type="text" readonly />
  </b-modal>
</template>

<script>
import { getInputFormatedDate, getInputFormatedCustomTime } from '~/assets/js/formatedDate.js'

export default {
  props: {
    selectedCourse: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      formularNewTitle: null,
      formularNewDate: null,
      formularNewTimeStart: null,
      formularNewTimeEnd: null,
      formularNewOccurence: null,
      formularNewTeacher: null,
      formularNewGroups: [],
      formularNewRoom: null,
      formularNewCampus: null
    }
  },
  watch: {
    selectedCourse (newSelectedCourse, oldSelectedCourse) {
      this.formularNewTimeStart = getInputFormatedCustomTime(newSelectedCourse.start)
      this.formularNewTimeEnd = getInputFormatedCustomTime(newSelectedCourse.end)
      this.formularNewTitle = newSelectedCourse.ue.field.value
      this.formularNewTeacher = newSelectedCourse.teacher.value
      this.formularNewRoom = newSelectedCourse.place.room.value
      this.formularNewCampus = newSelectedCourse.place.campus.value
      this.formularNewGroups = this.groupsTextExtractor(newSelectedCourse.groups)
    }
  },
  methods: {
    handleSubmit () {
      const course = {
        title: this.formularNewTitle,
        date: getInputFormatedDate(this.scheduleReferenceDate),
        start: this.formularNewTimeStart, // format "hh:mm"
        end: this.formularNewTimeEnd,
        occurences: this.formularNewOccurence,
        duration: this.formularNewDuration,
        groups: this.formularNewGroups,
        teacher: this.formularNewTeacher,
        room: this.formularNewRoom,
        campus: this.formularNewCampus
      }
      const callbackSendNewCourse = (course, status) => {
        this.makeToast(course, status)
      }
      this.sendNewCourse(course, callbackSendNewCourse)
    },
    sendNewCourse (course, callbackSendNewCourse) {
      console.log(course) // fetch ici
      const status = 0
      callbackSendNewCourse(course, status)
    },
    makeToast (course, status) {
      if (status === 0) {
        this.$bvToast.toast(`${course.title}`, {
          title: 'Echec de suppression',
          autoHideDelay: 10000,
          variant: 'danger',
          appendToast: false
        })
      } else {
        this.$bvToast.toast(`${course.title}`, {
          title: 'Cours supprimé',
          autoHideDelay: 5000,
          appendToast: false
        })
      }
    },
    groupsTextExtractor (groups) {
      const extract = []
      for (const group of groups) {
        extract.push(group.value)
      }
      return extract
    }
  }
}
</script>

<style scoped>
.formularContainer {
  color: black;
}
</style>
