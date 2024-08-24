<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated>
      <q-toolbar>
        <!-- <q-btn
          flat
          dense
          round
          icon="menu"
          aria-label="Menu"
          @click="toggleLeftDrawer"
        /> -->

        <q-toolbar-title> E-thin </q-toolbar-title>

        <!-- <div>Quasar v{{ $q.version }}</div> -->
      </q-toolbar>
    </q-header>

    <!-- <q-drawer v-model="leftDrawerOpen" show-if-above bordered>
      <q-list>
        <q-item-label header> Essential Links </q-item-label>

        <EssentialLink
          v-for="link in linksList"
          :key="link.title"
          v-bind="link"
        />
      </q-list>
    </q-drawer> -->

    <q-page-container>
      <router-view />
    </q-page-container>

    <q-footer v-if="!$route.meta.hideNav" class="">
      <q-tabs v-model="tab" class="text-white">
        <q-route-tab
          name="input"
          icon="edit"
          label=""
          :to="{ name: 'input' }"
        />
        <q-route-tab
          name="graph"
          icon="show_chart"
          label=""
          :to="{ name: 'graph' }"
        />
        <q-route-tab
          name="leader"
          icon="workspace_premium"
          label=""
          :to="{ name: 'leader' }"
        />
        <q-route-tab
          name="reward"
          icon="card_giftcard"
          label=""
          :to="{ name: 'reward' }"
        />
      </q-tabs>
    </q-footer>
  </q-layout>
</template>

<script setup lang="ts">
import { ref } from 'vue';

defineOptions({
  name: 'MainLayout',
});

const tab = ref('mails');

// const leftDrawerOpen = ref(false);

// function toggleLeftDrawer() {
//   leftDrawerOpen.value = !leftDrawerOpen.value;
// }
</script>
