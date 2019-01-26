<template>
  <div>
    <v-list-tile class="submenu-item"
      v-for="(item, index) in items"
      :key="index"
      v-bind:to="item.to"
      active-class="active-item"
    >
      <v-list-tile-title >{{ item.title }}</v-list-tile-title>
    </v-list-tile>
  </div>
</template>

<script>
export default {
  name: 'SubMenu',
  props: ['items'],
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
