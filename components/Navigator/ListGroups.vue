<template>
  <div style="height: 100%; width: 100%;">
    <b-input-group>
      <b-form-input v-model="researchTerms" type="search" placeholder="Recherche de groupes" list="list_groups" @keydown.enter="submitGroup(researchTerms)" />
      <b-form-datalist id="list_groups" :options="listGroups" />

      <b-input-group-append is-text>
        <b-icon-search @click="submitGroup(researchTerms)" />
      </b-input-group-append>
    </b-input-group>
    <br>
    <div>
      <div v-for="(group, key) in listGroupsTemp" :key="key">
        {{ listGroups.find(({value}) => value === Number(group)).text }}
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
      listGroupsTemp: []
    }
  },
  computed: {
  },
  watch: {
    listGroupsTemp () {
      // this.$emit('displayedGroupsEvent', this.groupsValueExtractor(this.listGroupsTemp))
    }
  },
  methods: {
    listGroupsTempReset () {
      this.listGroupsTemp = this.listGroups
    },
    submitGroup (researchTerms) {
      if (this.listGroups.find(({ value }) => value === Number(researchTerms)) !== undefined) { this.listGroupsTemp.push(researchTerms) }
      this.researchTerms = ''
    },
    groupsValueExtractor (groups) {
      const extract = []
      for (const group of groups) {
        extract.push(group.value)
      }
      return extract
    }

  }
}
</script>
