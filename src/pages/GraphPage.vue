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
    text: 'ApexLine',
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
    categories: [1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998],
  },
});
const series = ref([
  {
    name: 'series-1',
    data: [30, 40, 45, 50, 49, 60, 70, 91],
  },
]);
</script>
