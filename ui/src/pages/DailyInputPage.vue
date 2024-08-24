<template>
  <q-page class="row items-center justify-evenly">
    <div>
      Today: {{ date }}
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
    </div>
  </q-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
// import { QBtn, QFooter, QInput, QTab, QTabs, QTabPanel } from 'quasar';

defineOptions({
  name: 'DailyInputPage',
});

const date = ref(new Date().toDateString());
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
