<template>
  <v-menu open-on-hover offset-y v-if="this.items">
    <v-btn flat v-bind:to="this.to" slot="activator">{{this.title}}</v-btn>
    <SubMenu v-bind:items="this.items" :secondary="this.secondary"/>
  </v-menu>
  <v-btn v-else flat v-bind:to="this.to">{{this.title}}</v-btn>
</template>

<script>
import SubMenu from './SubMenu.vue';

export default {
  name: 'MenuItem',
  props: {
    title: {
      type: String,
      required: true,
    },
    to: {
      type: String,
      required: true,
    },
    items: Array,
    secondary: Boolean,
  },
  components: {
    SubMenu,
  },
};

</script>

<style scoped>

</style>
