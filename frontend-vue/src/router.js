import Vue from 'vue';
import Router from 'vue-router';
import Home from './views/Home.vue';
import AdminPosts from './components/admin/Posts.vue';
import AdminPost from './components/admin/Post.vue';

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
      path: '/admin/posts',
      name: 'admin-posts',
      component: AdminPosts,
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
