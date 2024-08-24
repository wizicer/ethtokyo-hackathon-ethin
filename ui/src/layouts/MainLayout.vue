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
        <ConnectWalletButton
          :address="address"
          :txnCount="0"
          :dark="false"
          @click="connect"
        >
          <!-- Override the default text on the "Connect Wallet" button -->
          Connect Wallet!

          <template #pending>
            <!-- Override the blue pending transaction div -->
          </template>

          <template #spinner>
            <!-- Use your own Spinner (svg, css, image, etc.) -->
          </template>

          <template #identicon>
            <!-- Use your own identicon library. Jazzicon is the default -->
          </template>

          <template #connectWalletButton>
            <!-- Use your own button for the "Connect Wallet" state when no address is provided -->
          </template>

          <template #addressButton>
            <!-- Use your own button to display the address when address is provided. Does not remove the pending transaction div -->
          </template>
        </ConnectWalletButton>
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
      <Suspense>
        <router-view />
      </Suspense>
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
import { ConnectWalletButton, useMetaMaskWallet } from 'vue-connect-wallet';

defineOptions({
  name: 'MainLayout',
});

const tab = ref('mails');

// const leftDrawerOpen = ref(false);

// function toggleLeftDrawer() {
//   leftDrawerOpen.value = !leftDrawerOpen.value;
// }

const wallet = useMetaMaskWallet();

const address = ref('');

wallet.onAccountsChanged((accounts: string[]) => {
  console.log('account changed to: ', accounts[0]);
});
wallet.onChainChanged((chainId: number) => {
  console.log('chain changed to:', chainId);
});

const connect = async () => {
  console.log('connect');
  const accounts = await wallet.connect();
  if (typeof accounts === 'string') {
    console.log('An error occurred' + accounts);
  }
  address.value = accounts[0];
};

const isConnected = async () => {
  const accounts = await wallet.getAccounts();
  if (typeof accounts === 'string') return false;
  return accounts.length > 0;
};

isConnected().then((value) => {
  if (value) connect();
});
</script>
