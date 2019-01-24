<template>
<div class="navigation">
  <v-toolbar>
    <v-toolbar-title>Admin</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-toolbar-items>
      <v-btn to="/admin/dashboard" flat>Dashboard</v-btn>
      <v-btn to="/admin/pages" flat>Oldalak</v-btn>
      <v-btn to="/admin/posts" flat>Hirek</v-btn>
      <v-btn to="/admin/users" flat>Felhasznalok</v-btn>
      <v-btn to="/admin/course_categories" flat>Esemény kategóriák</v-btn>
      <v-btn to="/admin/course_events"  flat>Tanfolyam események</v-btn>
      <v-btn to="/admin/courses" flat>Tanfolyamok</v-btn>
    </v-toolbar-items>
  </v-toolbar>
</div>
</template>

<script>
export default {
  name: 'Navigation',
  data: () => ({
  }),
};
</script>

<style scoped>

</style>
