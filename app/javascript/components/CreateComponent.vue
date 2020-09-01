<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" persistent max-width="600px">

      <v-card>
        <v-card-title>
          <span class="headline">新規登録</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>

              <v-col cols="12" sm="12" md="12">
                <v-text-field label="タイトル" required></v-text-field>
              </v-col>


              <v-col cols="6" sm="6" md="6">
                <v-chip
                    class="ma-2"
                    label
                >
                    Start
                </v-chip>
                <v-time-picker v-model="start" width="252"></v-time-picker>
              </v-col>


              <v-col cols="6" sm="6" md="6">
                <v-chip
                    class="ma-2"
                    label
                >
                    End
                </v-chip>
                <v-time-picker v-model="end" width="252"></v-time-picker>
              </v-col>


            </v-row>
          </v-container>
        
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="dialog = false">Close</v-btn>
          <v-btn color="blue darken-1" text @click="dialog = false">Save</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>
 

<script>
  export default {
    name: 'CreateComponent',
    data: () => ({
        dialog : true,
        start : null,
        end : null,
    })
  }
</script>
  