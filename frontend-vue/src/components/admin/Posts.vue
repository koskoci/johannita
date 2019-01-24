<template>
  <div>
    <v-toolbar flat color="white">
      <v-spacer></v-spacer>
      <v-btn color="success">új hír</v-btn>
    </v-toolbar>

    <v-data-table
      :headers="headers"
      :items="posts"
    >
      <template slot="items" slot-scope="props">
        <td>{{ props.item.id }}</td>
        <td>{{ new Date(props.item.attributes.created_at).toLocaleString('hu-HU') }}</td>
        <td>{{ props.item.attributes.title }}</td>
        <td>
          <v-btn icon v-bind:to="'/admin/posts/'+props.item.id+'/edit'">
            <v-icon>edit</v-icon>
          </v-btn>
          <v-btn icon to="/admin/posts/1/edit">
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
  name: 'Posts',
  data() {
    return {
      headers: [
        {
          text: 'ID', align: 'left', value: 'id',
        },
        { text: 'Létrehozva', align: 'left', value: 'attributes.created_at' },
        { text: 'Cim', align: 'left', value: 'attributes.title' },
        { text: 'Opciók', sortable: false },
      ],
      posts: [],
    };
  },
  mounted() {
    axios
      .get('http://206.189.55.142/api/posts')
      .then((response) => {
        // console.log(response.data.data);
        this.posts = response.data.data;
      });
  },
};
</script>

<style scoped>

</style>
