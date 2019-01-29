import Vue from 'vue';
import Router from 'vue-router';
import Home from './components/Home.vue';
import Login from './components/Login.vue';
import Page from './components/Page.vue';
import Post from './components/Post.vue';

Vue.use(Router);

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
    },
    {
      path: '/bejelentkezes',
      name: 'login',
      component: Login,
    },
    {
      path: '/regisztracio',
      name: 'registration',
      component: () => import('./components/Registration.vue'),
    },
    {
      path: '/oldal/:id',
      name: 'page',
      component: Page,
    },
    {
      path: '/hirek/:id',
      name: 'post',
      component: Post,
    },
    {
      path: '/admin/pages/new',
      name: 'admin-page-new',
      component: () => import('./components/admin/Page.vue'),
    },
    {
      path: '/admin/pages/:id/edit',
      name: 'admin-page',
      component: () => import('./components/admin/Page.vue'),
    },
    {
      path: '/admin/pages',
      name: 'admin-pages',
      component: () => import('./components/admin/Pages.vue'),
    },
    {
      path: '/admin/posts',
      name: 'admin-posts',
      component: () => import('./components/admin/Posts.vue'),
    },
    {
      path: '/admin/posts/:id/edit',
      name: 'admin-post',
      component: () => import('./components/admin/Post.vue'),
    },
    {
      path: '/admin/posts/new',
      name: 'admin-post-new',
      component: () => import('./components/admin/Post.vue'),
    },
  ],
});
