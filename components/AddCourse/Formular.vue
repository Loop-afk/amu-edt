<template>
  <b-modal
    id="modal-formular"
    title="Nouveau cours"
    scrollable
    centered
    @ok="handleSubmit"
  >
    <label>Matière</label>
    <b-form-input
      v-model="formularNewTitle"
      type="text"
      list="list_title"
      placeholder="Nom du cours"
      required
      :state="true"
    />
    <b-form-datalist id="list_title" :options="formularOptions.title" />

    <b-form-input v-model="formularNewTimeStart" type="time" />

    <b-form-input v-model="formularNewTimeEnd" type="time" />

    <b-form-select v-model="formularNewOccurence" :options="formularOptions.occurences" />

    <b-form-select v-model="formularNewDuration" :options="formularOptions.duration" />

    <b-form-input v-model="formularNewTeacher" type="text" list="list_teacher" placeholder="Professeur" />
    <b-form-datalist id="list_teacher" :options="formularOptions.teacher" />

    <b-form-tags v-model="formularNewGroups" tag-pills placeholder="Classes" :input-attrs="{ list: 'list_groups'}" />
    <b-form-datalist id="list_groups" :options="formularOptions.groups" />

    <b-form-input v-model="formularNewRoom" type="text" list="list_room" placeholder="Salle de cours" />
    <b-form-datalist id="list_room" :options="formularOptions.room" />

    <b-form-input v-model="formularNewCampus" type="text" list="list_campus" placeholder="Campus" />
    <b-form-datalist id="list_campus" :options="formularOptions.campus" />
  </b-modal>
</template>

<script>
import { getInputFormatedDate, getInputFormatedCustomTime } from '~/assets/js/formatedDate.js'

export default {
  props: {
    scheduleReferenceDate: {
      type: Date,
      required: true
    },
    selectedCourse: {
      type: Object,
      required: true
    },
    formularOptions: {
      type: Object,
      default: () => {},
      required: false
    }
  },
  data () {
    return {
      formularNewTitle: null,
      formularNewDate: null,
      formularNewTimeStart: null,
      formularNewTimeEnd: null,
      formularNewOccurence: null,
      formularNewDuration: null,
      formularNewTeacher: null,
      formularNewGroups: [],
      formularNewRoom: null,
      formularNewCampus: null
    }
  },
  watch: {
    selectedCourse (newSelectedCourse, oldSelectedCourse) {
      console.log('here')
      this.formularNewTimeStart = getInputFormatedCustomTime(newSelectedCourse.start)
      this.formularNewTimeEnd = getInputFormatedCustomTime(newSelectedCourse.end)
      this.formularNewTitle = newSelectedCourse.ue.field.value
      this.formularNewTeacher = newSelectedCourse.teacher.value
      this.formularNewRoom = newSelectedCourse.place.room.value
      this.formularNewCampus = newSelectedCourse.place.campus.value
      this.formularNewGroups = this.groupsTextExtractor(newSelectedCourse.groups)
      console.log(newSelectedCourse.groups)
      console.log(this.formularNewGroups)
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
          title: 'Echec d\'ajout',
          autoHideDelay: 10000,
          variant: 'danger',
          appendToast: false
        })
      } else {
        this.$bvToast.toast(`${course.title}`, {
          title: 'Cours ajouté',
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
