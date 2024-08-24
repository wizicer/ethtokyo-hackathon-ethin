<template>
  <q-page class="row items-center justify-evenly">
    <div>
      <q-input
        v-model="name"
        label="Name"
        @change="checkNameAvailability"
        outlined
        dense
      />
      <div v-if="nameStatus">
        <q-icon
          :name="nameStatus.icon"
          :color="nameStatus.color"
          class="q-mr-sm"
        />
        <span :style="{ color: nameStatus.color }">{{
          nameStatus.message
        }}</span>
      </div>
      <q-btn
        :disable="!nameAvailable"
        label="Claim"
        @click="claimName"
        color="primary"
      />
    </div>
  </q-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { QBtn, QIcon, QInput } from 'quasar';
import { useRouter } from 'vue-router';
const router = useRouter();

defineOptions({
  name: 'ClaimNamePage',
});

const name = ref('');
const nameAvailable = ref(false);
const nameStatus = ref<{ icon: string; color: string; message: string } | null>(
  {
    icon: 'feedback',
    color: 'grey',
    message: 'Please enter a name',
  }
);

const checkNameAvailability = () => {
  if (name.value.length > 3) {
    nameAvailable.value = true; // Replace with actual availability check
    nameStatus.value = {
      icon: 'check_circle',
      color: 'green',
      message: 'Name is available',
    };
  } else {
    nameAvailable.value = false;
    nameStatus.value = {
      icon: 'cancel',
      color: 'red',
      message: 'Name is not available',
    };
  }
};

const claimName = () => {
  // Handle claiming the name
  console.log('Name claimed:', name.value);
  router.push({ name: 'input' });
};
</script>
