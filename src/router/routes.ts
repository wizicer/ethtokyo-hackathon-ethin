import { RouteRecordRaw } from 'vue-router';

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      {
        path: '',
        redirect: 'init',
      },
      {
        name: 'init',
        path: 'init',
        meta: { hideNav: true },
        component: () => import('pages/InitializationPage.vue'),
      },
      {
        name: 'input',
        path: 'input',
        component: () => import('pages/DailyInputPage.vue'),
      },
      {
        name: 'graph',
        path: 'graph',
        component: () => import('pages/GraphPage.vue'),
      },
      {
        name: 'leader',
        path: 'leader',
        component: () => import('pages/LeaderboardPage.vue'),
      },
      {
        name: 'claim',
        path: 'claim',
        meta: { hideNav: true },
        component: () => import('pages/ClaimNamePage.vue'),
      },
      {
        name: 'reward',
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
