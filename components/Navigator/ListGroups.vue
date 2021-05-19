<template>
  <div style="height: 100%; width: 100%;">
    <b-input-group>
      <b-form-input v-model="researchTerms" type="search" placeholder="Recherche de groupes" />
      <b-input-group-append is-text>
        <b-icon-search />
      </b-input-group-append>
    </b-input-group>
    <br>
    <div>
      <div v-for="(group, key) in listGroupsTemp" :key="key">
        {{ key }} : {{ group }}
      </div>
    </div>
  </div>
</template>

<script>
import { BIconSearch } from 'bootstrap-vue'
export default {
  components: {
    BIconSearch
  },
  props: {
    listGroups: {
      type: Array,
      default: () => { return [] },
      required: false
    }
  },
  data () {
    return {
      researchTermsData: null,
      listGroupsTemp: this.listGroups
    }
  },
  computed: {
    researchTerms: {
      set (value) {
        this.researchTermsData = value
        this.listGroupsTemp = this.listGroups
        this.listGroupsTemp.push(value)
      },
      get () {
        return this.researchTermsData
      }
    }
  },
  watch: {

  },
  methods: {
    listGroupsTempReset () {
      this.listGroupsTemp = this.listGroups
    }
  }
}
</script>
