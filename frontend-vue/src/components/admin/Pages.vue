<template>
<div>
  <v-toolbar flat color="white">
    <v-spacer></v-spacer>
    <v-btn to="/admin/pages/new" color="success">új oldal</v-btn>
  </v-toolbar>
  <v-data-table
      :headers="headers"
      :items="pages"
    >
      <template slot="items" slot-scope="props">
        <td>{{ props.item.id }}</td>
        <td>{{ props.item.attributes.short_name }}</td>
        <td>
          <v-btn icon v-bind:to="'/admin/pages/'+props.item.attributes.short_name+'/edit'">
            <v-icon>edit</v-icon>
          </v-btn>
          <v-btn icon @click="deletePage(props.item.attributes.short_name)">
            <v-icon>delete</v-icon>
          </v-btn>
        </td>
      </template>
    </v-data-table>
</div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'Pages',
  data() {
    return {
      headers: [
        { text: 'ID', align: 'left', value: 'id' },
        { text: 'Slug', align: 'left', value: 'attributes.short_name' },
        { text: 'Opciók', sortable: false },
      ],
      pages: [],
    };
  },
  mounted() {
    axios
      .get('http://206.189.55.142/api/pages')
      .then((response) => {
        console.log(response.data.data);
        this.pages = response.data.data;
      });
  },
  methods: {
    deletePage(slug) {
      // eslint-disable-next-line
      if (confirm(`Tényleg törölni szeretnéd a(z) ${slug} odalt?`)) {
        console.log('Delete page', slug);
        axios
          .delete(
            `http://206.189.55.142/api/pages/${slug}`,
            {
              headers: {
                Authorization: `Bearer ${window.localStorage.getItem('user_token')}`,
                Accept: 'application/vnd.api+json',
                'Content-Type': 'application/vnd.api+json',
              },
            },
          )
          .then((response) => {
            console.log(response);
            window.location.replace('/admin/pages');
          });
      } else {
        // Do nothing!
      }
    },
  },
};
</script>

<style scoped>

</style>
