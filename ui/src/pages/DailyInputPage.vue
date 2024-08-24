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

const submitWeight = async () => {
  if (weight.value) {
    // Handle weight submission
    await submit();
    console.log('Weight submitted:', weight.value);
  } else {
    console.error('Please enter your weight');
  }
};

import { BrowserProvider, ethers, JsonRpcSigner } from 'ethers';
import { L2Contract__factory } from 'src/contracts';

import { QSpinnerClock, useQuasar } from 'quasar';
import { buildMimcSponge } from 'circomlibjs';

const initializing = ref(false);

const $q = useQuasar();

let signer: JsonRpcSigner | null = null;
const account = ref('');

let provider: BrowserProvider;
if (window.ethereum == null) {
  console.log('metamask not found');
  $q.notify('metamask not found');
} else {
  provider = new ethers.BrowserProvider(window.ethereum, 1337);
  signer = await provider.getSigner();
  account.value = await signer.getAddress();
}
let hasher: MimcSponge;
buildMimcSponge().then((_) => (hasher = _));

function hash(arr: bigint[]): bigint {
  var h: Uint8Array = hasher.multiHash(arr, undefined, undefined);
  return BigInt(hasher.F.toString(h, 10));
}

async function submit() {
  if (weight.value == null) {
    $q.notify({
      message: 'Please fill out all fields',
      color: 'negative',
    });
    return false;
  }
  initializing.value = true;
  try {
    const dt = L2Contract__factory.connect(
      '0x698170b76f32eab533352ec5eac670a116f43a77',
      signer
    );

    const pk = account.value.replace('0x', '0x000000000000000000000000');
    try {
      const t = await dt.dailyCommitments(
        pk,
        '0x' + hash([BigInt(weight.value)]).toString(16)
      );

      $q.loading.show({
        message: 'Waiting Transaction to be included in Blockchain',
        boxClass: 'bg-grey-2 text-grey-9',
        spinnerColor: 'primary',
        spinner: QSpinnerClock,
      });
      console.log(t);
      // const d = await t.wait();
      initializing.value = true;
      return true;
    } catch (err) {
      if (err instanceof Error) {
        if (err.message.startsWith('missing revert data'))
          $q.notify({
            message: 'Invalid transaction! (maybe invalid proof)',
            color: 'negative',
          });
        else console.log(err.message);
      } else {
        console.warn('unknown error', err);
      }
      return false;
    }
  } finally {
    $q.loading.hide();
    initializing.value = true;
  }
}
</script>
