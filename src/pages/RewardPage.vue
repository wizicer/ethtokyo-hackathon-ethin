<template>
  <q-page class="column items-start q-ma-md">
    <q-card class="q-mb-md full-width">
      <q-card-section class="row items-center">
        <div class="col">
          <div class="text-h6">{{ userName }}</div>
          <div class="text-caption">{{ userPoints }} points</div>
        </div>
        <q-badge color="primary" label="#{{ userRank }}" />
      </q-card-section>
    </q-card>

    <q-list bordered class="scroll full-width">
      <q-item v-for="(task, index) in tasks" :key="index" clickable>
        <q-item-section>
          <q-item-label>{{ task.name }}</q-item-label>
          <q-item-label caption>{{ task.summary }}</q-item-label>
        </q-item-section>
        <q-item-section side>
          <q-btn label="Prove" color="primary" />
        </q-item-section>
      </q-item>
    </q-list>
  </q-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import {
  QBadge,
  QBtn,
  QCard,
  QCardSection,
  QList,
  QItem,
  QItemLabel,
  QItemSection,
} from 'quasar';

defineOptions({
  name: 'RewardPage',
});

const userName = ref('User Name');
const userPoints = ref(120);
const userRank = ref(5);
console.log(userRank);

const tasks = ref([
  { name: 'Task 1', summary: 'Summary of task 1' },
  { name: 'Task 2', summary: 'Summary of task 2' },
  // Add more tasks as needed
]);
</script>

<style scoped>
.scroll {
  max-height: 200px;
  overflow-y: auto;
}
</style>
