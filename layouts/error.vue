<template>
  <div>
    <h1 v-if="error.statusCode === 404">
      Page non trouvé
    </h1>
    <h1 v-else-if="error.statusCode === 500">
      Erreur interne
    </h1>
    <h1 v-else>
      Une erreur est survenue
    </h1>
  </div>
</template>

<script>
export default {
  props: ['error']
}
</script>
