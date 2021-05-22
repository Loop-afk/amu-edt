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
      <b-button v-for="(group, key) in listGroupsTemp" :key="key" pill variant="outline-danger" @click="removeFromDisplayedGroups(group)">
        {{ group }}
      </b-button>
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
      researchTerms: null,
      listGroupsTemp: []
    }
  },
  computed: {
  },

  methods: {
    listGroupsTempReset () {
      this.listGroupsTemp = this.listGroups
    },
    submitGroup (researchTerms) {
      const listGroupEntry = this.listGroups.find(({ value }) => value === researchTerms)
      if (listGroupEntry !== undefined) { this.listGroupsTemp.push(listGroupEntry.value); this.$emit('displayedGroupsEvent', this.createDisplayedGroups(this.listGroups, this.listGroupsTemp)) } else { this.researchTerms = '' }
    },
    createDisplayedGroups (listGroups, listGroupsTemp) {
      const listGroupEntries = []
      for (const group of listGroupsTemp) { listGroupEntries.push(listGroups.find(({ value }) => value === group).text) }
      return listGroupEntries
    },
    removeFromDisplayedGroups (group) {
      this.listGroupsTemp = this.listGroupsTemp.filter(current => current !== group)
      this.$emit('displayedGroupsEvent', this.createDisplayedGroups(this.listGroups, this.listGroupsTemp))
    }
  }
}
</script>
