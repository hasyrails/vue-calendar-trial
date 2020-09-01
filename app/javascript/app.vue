<template>
  <div id="app">
    <v-app>
      <calenderComponent></calenderComponent>
    </v-app>
  </div>
</template>

<script>
import calenderComponent from "./components/CalendarComponent.vue";

export default {
  data: function () {
    return {
    }
  },
  components: {
    calenderComponent
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
