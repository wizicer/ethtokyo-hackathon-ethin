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

const handleSubmit = () => {
  if (height.value && weight.value && sex.value) {
    // Handle form submission
    console.log('Form submitted', {
      sex: sex.value,
      height: height.value,
      weight: weight.value,
    });
  } else {
    // Handle form validation
    console.error('Please fill out all fields');
  }
};
</script>
