<template>
  <div>
    <v-sheet height="500">
      <v-calendar
          ref="calendar"
          locale="ja-jp"
          :type="type"
          :now="today"
          :value="today"
          :events="events"
          color="primary"
      ></v-calendar>
    </v-sheet>
  </div>
</template>


<script>
  export default {
    data: () => ({
    today: `2020-05-19`,
    type:'month',
    datas:[],
    events: [
        {
          name: 'あたりまえ体操をする',
          start: '2020-05-18',
          end: '2020-05-1',
        },
        {
          name: 'Meeting',
          start: '2020-05-1 09:00',
          end: '2020-05-1 10:00',
        },
      ],
    }),
    computed:{
   
    },
    mounted () {

    },
    methods:{

    }
  }
</script>
