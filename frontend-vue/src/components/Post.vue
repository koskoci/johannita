<template>
  <div>
    <div v-if="loading" class="loading">
      Loading...
    </div>
    <div v-if="error" class="error">
      {{ error }}
    </div>
    <div v-if="post" class="content">
      <h1 v-html="post.attributes.title" class="header"></h1>
      <h3
        v-html="new Date(post.attributes.created_at).toLocaleDateString('hu-HU')"
        class="header"></h3>
      <div v-html="post.attributes.content"></div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'Post',
  data: () => ({
    loading: false,
    error: null,
    post: null,
  }),
  created() {
    this.fetchData();
  },
  watch: {
    // call again the method if the route changes
    $route: 'fetchData',
  },
  methods: {
    fetchData() {
      this.error = null;
      this.post = null;
      this.loading = true;
      const { id } = this.$route.params;
      const apiUrl = 'http://206.189.55.142/api/';
      const url = `${apiUrl}posts/${id}`;
      axios.get(
        url,
        {
          headers: {
            Accept: 'application/json',
            'Content-Type': 'application/vnd.api+json',
          },
        },
      ).then((res) => {
        this.loading = false;
        this.post = res.data.data;
      }).catch((err) => {
        this.loading = false;
        this.error = err.response.data.error;
      });
    },
  },
};
</script>

<style lang="scss" scoped>
  .content {
    max-width: 800px;
    margin: 20px auto;
    .header {
      color: red;
    }
  }
</style>
