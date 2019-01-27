<template>
  <div>
    <div class="loading" v-if="loading">
      Loading...
    </div>
    <div v-if="error" class="error">
      {{ error }}
    </div>
    <div v-if="page" class="content">
      {{page.attributes.content}}
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'Page',
  data: () => ({
    loading: false,
    error: null,
    page: null,
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
      this.page = null;
      this.loading = true;
      const { id } = this.$route.params;
      const apiUrl = 'http://206.189.55.142/api/';
      const url = `${apiUrl}pages/${id}`;
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
        this.page = res.data.data;
      }).catch((err) => {
        this.loading = false;
        this.error = err.response.data.error;
      });
    },
  },
};
</script>

<style scoped>

</style>
