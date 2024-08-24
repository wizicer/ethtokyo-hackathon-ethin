<template>
  <q-page class="column items-start">
    <q-list bordered class="scroll">
      <q-item v-for="(user, index) in leaderboard" :key="index" clickable>
        <q-item-section>
          <q-item-label>{{ user.name }}</q-item-label>
          <q-item-label caption>{{ user.points }} points</q-item-label>
        </q-item-section>
        <q-item-section side>
          <q-badge color="primary" label="#{{ user.rank }}" />
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
</script>

<style scoped>
.scroll {
  max-height: 300px;
  overflow-y: auto;
}
</style>
