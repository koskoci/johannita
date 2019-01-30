<template>
  <div>
    <div v-if="loading" class="loading">
      Loading...
    </div>

    <div v-if="error" class="error">
      {{ error }}
    </div>

    <div v-if="posts" class="content">
      <v-content>
        <v-layout row>
          <v-flex xs3></v-flex>
          <v-flex xs6>
            <v-timeline dense>
              <v-timeline-item
                to="/hirek/1"
                color="red"
                v-for="post in posts"
                :key="post.id"
                right
                small
              >
          <span
            slot="opposite"
            :class="`font-weight-bold red--text xs3 post-date-wrapper`"
            v-text="new Date(post.attributes.created_at).toLocaleDateString('hu-HU')"
          ></span>
                <router-link class="post-wrapper" :to="'/hirek/'+post.id">
                  <img class="thumbnail-image"
                    v-if="post.attributes.thumbnail_url"
                    :src="post.attributes.thumbnail_url"
                    alt="thumb"/>
                  <h2
                    :class="`headline font-weight-light mb-3 red--text`"
                  >{{post.attributes.title}}
                  </h2>
                  <div class="blurb" v-html="post.attributes.blurb">
                  </div>
                </router-link>
              </v-timeline-item>
            </v-timeline>
          </v-flex>
          <v-flex xs2></v-flex>
        </v-layout>
      </v-content>
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

<style lang="scss" scoped>
  a {
    text-decoration: none;

    .blurb {
      color: black;
    }
  }

  .thumbnail-image {
    float: right;
    max-width: 100px;
    max-height: 100px;
    margin-left: 10px;
    margin-bottom: 10px;
  }

  .post-wrapper {
    display: block;
    margin-bottom: 40px;
  }
</style>
