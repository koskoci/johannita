<template>
  <div id="page-content">{{content}}</div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'Page',
  data: () => ({
    content: 'default',
  }),
  mounted() {
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
      this.content = res.data.data.attributes.content;
    }).catch((err) => {
      this.content = err.response.data.error;
    });
  },
};
</script>

<style scoped>
  #page-content {
    margin: 20px 0;
  }
</style>
