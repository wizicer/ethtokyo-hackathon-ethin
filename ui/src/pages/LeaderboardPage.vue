<template>
  <q-page class="column items-start q-ma-md">
    <q-card class="q-mb-md full-width">
      <q-card-section class="row items-center">
        <div class="col">
          <div class="text-h6">{{ userName }}</div>
          <div class="text-caption">{{ userPoints }} points</div>
        </div>
        <q-badge color="primary" :label="'#' + userRank" />
      </q-card-section>
    </q-card>
    <q-list bordered class="scroll full-width">
      <q-item v-for="(user, index) in leaderboard" :key="index" clickable>
        <q-item-section>
          <q-item-label>{{ user.name }}</q-item-label>
          <q-item-label caption>{{ user.points }} points</q-item-label>
        </q-item-section>
        <q-item-section side>
          <q-badge color="primary" :label="'#' + userRank" />
        </q-item-section>
      </q-item>
    </q-list>
  </q-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { QBadge, QList, QItem, QItemLabel, QItemSection } from 'quasar';

defineOptions({
  name: 'LeaderboardPage',
});

const leaderboard = ref([
  { name: 'User 1', points: 150, rank: 1 },
  { name: 'User 2', points: 120, rank: 2 },
  // Add more users as needed
]);
const userName = ref('User Name');
const userPoints = ref(120);
const userRank = ref(5);
</script>

<style scoped>
.scroll {
  max-height: 300px;
  overflow-y: auto;
}
</style>
