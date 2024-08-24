<template>
  <q-page class="row items-center justify-evenly">
    <q-form @submit="handleSubmit" class="col-10 q-gutter-md">
      <q-select
        v-model="sex"
        :options="sexOptions"
        label="Sex"
        emit-value
        map-options
        dense
        outlined
      />
      <q-input
        v-model="height"
        label="Height (cm)"
        type="number"
        dense
        outlined
      />
      <q-input
        v-model="weight"
        label="Weight (kg)"
        type="number"
        dense
        outlined
      />
      <q-btn label="Submit" type="submit" color="primary" class="full-width" />
    </q-form>
  </q-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { QForm } from 'quasar';
import { useRouter } from 'vue-router';
const router = useRouter();

defineOptions({
  name: 'InitializationPage',
});

const sex = ref('');
const height = ref<number | null>(null);
const weight = ref<number | null>(null);

const sexOptions = [
  { label: 'Male', value: 'male' },
  { label: 'Female', value: 'female' },
];

const handleSubmit = async () => {
  if (height.value && weight.value && sex.value) {
    var ret = await submit();
    if (!ret) {
      console.error('Failed to submit');
      return;
    }
    console.log('Form submitted', {
      sex: sex.value,
      height: height.value,
      weight: weight.value,
    });
    router.push({ name: 'input' });
  } else {
    // Handle form validation
    console.error('Please fill out all fields');
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
  if (!height.value || !weight.value) return;
  initializing.value = true;
  try {
    const dt = L2Contract__factory.connect(
      '0x698170b76f32eab533352ec5eac670a116f43a77',
      signer
    );

    const pk = account.value.replace('0x', '0x000000000000000000000000');
    try {
      const t = await dt.create_account(
        pk,
        '0x' + hash([BigInt(height.value)]).toString(16)
      );

      $q.loading.show({
        message: 'Waiting Transaction to be included in Blockchain',
        boxClass: 'bg-grey-2 text-grey-9',
        spinnerColor: 'primary',
        spinner: QSpinnerClock,
      });
      await t.wait();
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
