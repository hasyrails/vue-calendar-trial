<template>
  <div id="app">
    <v-app>
      <CalenderComponent>
      </CalenderComponent>
    </v-app>
  </div>
</template>

<script>
import CalenderComponent from "./components/CalendarComponent.vue";


export default {
  data: function () {
    return {
    }
  },
  components: {
    CalenderComponent,
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
