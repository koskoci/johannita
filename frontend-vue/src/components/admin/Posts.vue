<template>
  <div>
    <v-toolbar flat color="white">
      <v-spacer></v-spacer>
      <v-btn to="/admin/posts/new" color="success">új hír</v-btn>
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
          <v-btn icon @click="deletePost(props.item.id, props.item.attributes.title)">
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
        this.posts = response.data.data;
      });
  },
  methods: {
    deletePost(id, title) {
      // eslint-disable-next-line
      if (confirm(`Tényleg törölni szeretnéd a(z) ${title} című (${id}) hírt?`)) {
        console.log('Delete post', id);
        axios
          .delete(
            `http://206.189.55.142/api/posts/${id}`,
            {
              headers: {
                Authorization: `Bearer ${window.localStorage.getItem('user_token')}`,
                Accept: 'application/vnd.api+json',
                'Content-Type': 'application/vnd.api+json',
              },
            },
          ).then((response) => {
            console.log(response);
            window.location.replace('/admin/posts');
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
