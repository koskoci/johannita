<template>
  <div>
    <template v-for="(item, index) in items">
      <v-list-tile v-if="item.to" v-bind:class="getClass()"
                   :key="index"
                   v-bind:to="item.to"
                   active-class="active-item"
      >
        <v-list-tile-title>{{ item.title }}</v-list-tile-title>
      </v-list-tile>
      <v-list-tile v-else v-bind:class="getClass()"
                   :key="index"
                   v-on:click=item.click
      >
        <v-list-tile-title>{{ item.title }}</v-list-tile-title>
      </v-list-tile>
    </template>
  </div>
</template>

<script>
export default {
  name: 'SubMenu',
  props: ['items', 'secondary'],
  methods: {
    getClass() {
      if (this.secondary) {
        return 'submenu-item secondary-submenu-item';
      }
      return 'submenu-item';
    },
  },
};
</script>

<style scoped>
  .submenu-item {
    background-color: white;
  }

  .submenu-item:hover {
    color: red;
    background-color: #ffe1e4;
  }
</style>
