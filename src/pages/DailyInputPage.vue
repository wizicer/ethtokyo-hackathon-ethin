<template>
  <q-page class="column items-center justify-evenly">
    <q-input
      v-model="weight"
      label="Weight (kg)"
      type="number"
      dense
      outlined
    />
    <q-btn
      label="Submit"
      @click="submitWeight"
      color="primary"
      class="full-width"
    />
    <q-footer class="q-pa-md">
      <!-- <q-tab-panels model="tab">
        <q-tabs inline-label v-model="tab" dense>
          <q-tab name="home" label="Home" icon="home" />
          <q-tab name="rewards" label="Rewards" icon="star" />
          <q-tab name="graph" label="Graph" icon="show_chart" />
          <q-tab name="leaderboard" label="Leaderboard" icon="leaderboard" />
        </q-tabs>
      </q-tab-panels> -->
    </q-footer>
  </q-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
// import { QBtn, QFooter, QInput, QTab, QTabs, QTabPanel } from 'quasar';

defineOptions({
  name: 'DailyInputPage',
});

const weight = ref<number | null>(null);
// const tab = ref('home');

const submitWeight = () => {
  if (weight.value) {
    // Handle weight submission
    console.log('Weight submitted:', weight.value);
  } else {
    console.error('Please enter your weight');
  }
};
</script>
s
