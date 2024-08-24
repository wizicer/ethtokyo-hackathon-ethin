<template>
  <q-page class="row items-center justify-evenly">
    <q-card>
      <q-card-section>
        <q-bar-chart
          :labels="labels"
          :datasets="datasets"
          options="graphOptions"
        />
      </q-card-section>
    </q-card>
  </q-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
// import { QBarChart } from 'quasar';

defineOptions({
  name: 'GraphPage',
});

const labels = ref(['Jan', 'Feb', 'Mar', 'Apr', 'May']); // Example labels
const datasets = ref([
  {
    label: 'Weight',
    backgroundColor: 'blue',
    data: [70, 68, 67, 66, 65],
  },
]);

const graphOptions = {
  scales: {
    x: {
      title: {
        display: true,
        text: 'Date',
      },
    },
    y: {
      title: {
        display: true,
        text: 'Weight (kg)',
      },
    },
  },
};
console.log(graphOptions);
</script>
