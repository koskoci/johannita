<template>
  <div>
    <div v-if="loading" class="loading">
      Loading...
    </div>

    <div v-if="error" class="error">
      {{ error }}
    </div>

    <div v-if="posts" class="content">
      <v-timeline>
        <v-timeline-item
          color="red"
          v-for="post in posts"
          :key="post.id"
          class="mb-3"
          right
          small
        >
          <span
            slot="opposite"
            :class="`font-weight-bold red--text`"
            v-text="new Date(post.attributes.created_at).toLocaleDateString('hu-HU')"
          ></span>
          <div class="">
            <h2 :class="`headline font-weight-light mb-3 red--text`">{{post.attributes.title}}</h2>
            <div>
              {{post.attributes.content}} ---
              Lorem ipsum dolor sit amet, no nam oblique veritus.
              Commune scaevola imperdiet nec ut, sed euismod convenire
              principes at. Est et nobis iisque percipit,
              an vim zril disputando voluptatibus, vix an salutandi sententiae.
            </div>
          </div>
        </v-timeline-item>
      </v-timeline>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'Home',
  data: () => ({
    posts: [],
  }),
  created() {
    this.fetchData();
  },
  methods: {
    fetchData() {
      this.error = null;
      this.posts = null;
      this.loading = true;
      const apiUrl = 'http://206.189.55.142/api/';
      const url = `${apiUrl}posts`;
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
        this.posts = res.data.data.reverse();
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
