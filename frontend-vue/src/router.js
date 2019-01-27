import Vue from 'vue';
import Router from 'vue-router';
import Home from './components/Home.vue';
import Login from './components/Login.vue';
import Page from './components/Page.vue';
import Post from './components/Post.vue';
import AdminPosts from './components/admin/Posts.vue';
import AdminPost from './components/admin/Post.vue';
import Registration from './components/Registration.vue';

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
      component: Registration,
    },
    {
      path: '/admin/posts',
      name: 'admin-posts',
      component: AdminPosts,
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
      path: '/admin/posts/:id/edit',
      name: 'admin-posts-edit',
      component: AdminPost,
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (about.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import(/* webpackChunkName: "about" */ './views/About.vue'),
    },
  ],
});
