<template>
  <q-page class="row items-center justify-evenly">
    <q-card>
      <q-card-section>
        <apexchart
          height="300"
          type="line"
          :options="options"
          :series="series"
        ></apexchart>
      </q-card-section>
    </q-card>
  </q-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { getCssVar } from 'quasar';

defineOptions({
  name: 'GraphPage',
});
const options = ref({
  title: {
    text: 'Graph',
    align: 'left',
  },
  chart: {
    id: 'apex-line',
  },
  colors: [getCssVar('primary'), getCssVar('secondary'), getCssVar('negative')],
  markers: {
    size: 4,
    hover: {
      sizeOffset: 6,
    },
  },
  xaxis: {
    categories: [
      '2024-08-19',
      '2024-08-20',
      '2024-08-21',
      '2024-08-22',
      '2024-08-23',
      '2024-08-24',
      '2024-08-25',
    ],
  },
});
const series = ref([
  {
    name: 'series-1',
    data: [88, 87, 86, 86, 87, 85, 85],
  },
]);
</script>
