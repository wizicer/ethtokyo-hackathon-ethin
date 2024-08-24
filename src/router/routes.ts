import { RouteRecordRaw } from 'vue-router';

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      {
        path: '',
        component: () => import('pages/IndexPage.vue'),
      },
      {
        path: 'init',
        component: () => import('pages/InitializationPage.vue'),
      },
      {
        path: 'input',
        component: () => import('pages/DailyInputPage.vue'),
      },
      {
        path: 'graph',
        component: () => import('pages/GraphPage.vue'),
      },
      {
        path: 'leader',
        component: () => import('pages/LeaderboardPage.vue'),
      },
      {
        path: 'claim',
        component: () => import('pages/ClaimNamePage.vue'),
      },
      {
        path: 'reward',
        component: () => import('pages/RewardPage.vue'),
      },
    ],
  },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/ErrorNotFound.vue'),
  },
];

export default routes;
