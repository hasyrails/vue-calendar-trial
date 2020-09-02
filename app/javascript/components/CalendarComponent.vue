<template>
  <div>
    <div id="form-modal">
      <createComponent ref="form" @save="saveEvent"></createComponent>
    </div>

    <v-menu bottom right>
      <template v-slot:activator="{ on }">
        <v-btn
          outlined
          color="grey darken-2"
          v-on="on"
        >
          <span>{{type}}</span>
        </v-btn>
      </template>

      <v-list>
        <v-list-item @click="type = 'day'">
          <v-list-item-title>Day</v-list-item-title>
        </v-list-item>
        <v-list-item @click="type = 'week'">
          <v-list-item-title>Week</v-list-item-title>
        </v-list-item>
        <v-list-item @click="type = 'month'">
          <v-list-item-title>Month</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>

    <v-sheet height="500">
      <v-calendar
          ref="calendar"
          locale="ja-jp"
          :type="type"
          :now="today"
          :value="today"
          :events="events"
          color="primary"
          @click:event="clickEvent"
          @click:date="showDay"
          @click:day="createEvent"
      ></v-calendar>
    </v-sheet>
  </div>
</template>


<script>
  import createComponent from '../components/CreateComponent'
  export default {
    name: 'calendarComponent',
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
    components: {
      createComponent
    },
    computed:{
    },
    mounted () {

    },
    methods:{
      showDay( { date } ){
        this.today = date
        this.type = 'day'
      },
      createEvent({ date }){
        this.$refs.form.open(date);
      },
      saveEvent(params){
        console.log("calendarcompoennt.xue");
        this.events.push(params);
        console.log(`保存しました。${params}`)
      },
       // event → day の順番で呼ばれる。
      clickEvent( {nativeEvent,event} ){
        console.log("clickEvetn");
        console.log(event);
        console.log(event.name)
        
        //次にcreateEventが走ってしまうのを防御する
        nativeEvent.stopPropagation();
        
      }
    }
  }
</script>
