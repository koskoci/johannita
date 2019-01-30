<template>
  <div id="post-edit">
    <v-form v-model="valid">
      <v-container>
        <v-layout row wrap>
          <v-flex shrink>
            <v-dialog v-model="thumbnail_dialog" width="800">
              <div slot="activator">
                <img
                  v-if="this.post.attributes.thumbnail_url"
                  :src="this.post.attributes.thumbnail_url"
                  height="100" alt="thumbnail"
                />
                <v-btn v-else>Előkép hozzáadása</v-btn>
              </div>

              <v-card>
                <v-card-title>
                  <h2>
                    Előkép beillesztés
                  </h2>
                </v-card-title>
                <v-form>
                  <v-container>
                    <v-layout row wrap>
                      <v-flex
                        xs12
                        class="text-xs-center text-sm-center text-md-center text-lg-center"
                      >
                        <img
                          v-if="this.post.attributes.thumbnail_url"
                          :src="this.post.attributes.thumbnail_url"
                          height="100" alt="thumbnail"
                        />

                        <v-text-field
                          label="Kép kiválasztása"
                          @click='pickThumbnail'
                          v-model='thumbnail.name'
                          prepend-icon='attach_file'></v-text-field>
                        <input
                          type="file"
                          style="display: none"
                          ref="thumbnail"
                          accept="image/*"
                          @change="onFilePickedThumbnail"
                        >
                      </v-flex>
                    </v-layout>
                  </v-container>
                </v-form>

                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn @click="cancelInsertImage">Mégsem</v-btn>
                  <v-btn
                    color="success"
                    @click="addThumbnail"
                  >
                    Beillesztés
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
          </v-flex>
          <v-flex>
            <v-text-field
              v-model="post.attributes.title"
              :rules="[v => !!v || 'megadása kötelező!']"
              :counter="100"
              label="Cím"
              required
            ></v-text-field>
          </v-flex>
        </v-layout>
      </v-container>
      <v-text-field
        v-model="post.attributes.blurb"
        :rules="[v => !!v || 'megadása kötelező!']"
        :counter="2000"
        label="Rövid leírás"
        hint="megjelenik a főoldalon"
        required
      ></v-text-field>

      <editor-menu-bar :editor="editor">
        <div slot-scope="{ commands, isActive }">
          <v-btn icon
                 class="menubar__button"
                 :class="{ 'is-active': isActive.bold() }"
                 @click="commands.bold"
          >
            <v-icon>format_bold</v-icon>
          </v-btn>
          <v-btn icon
                 class="menubar__button"
                 :class="{ 'is-active': isActive.italic() }"
                 @click="commands.italic"
          >
            <v-icon>format_italic</v-icon>
          </v-btn>
          <v-btn icon
                 class="menubar__button"
                 :class="{ 'is-active': isActive.strike() }"
                 @click="commands.strike"
          >
            <v-icon>strikethrough_s</v-icon>
          </v-btn>
          <v-btn icon
                 class="menubar__button"
                 :class="{ 'is-active': isActive.underline() }"
                 @click="commands.underline"
          >
            <v-icon>format_underline</v-icon>
          </v-btn>
          <v-btn icon
                 class="menubar__button"
                 :class="{ 'is-active': isActive.heading({ level: 1 }) }"
                 @click="commands.heading({ level: 1 })"
          >
            H1
          </v-btn>
          <v-btn icon
                 class="menubar__button"
                 :class="{ 'is-active': isActive.heading({ level: 2 }) }"
                 @click="commands.heading({ level: 2 })"
          >
            H2
          </v-btn>
          <v-btn icon
                 class="menubar__button"
                 :class="{ 'is-active': isActive.heading({ level: 3 }) }"
                 @click="commands.heading({ level: 3 })"
          >
            H3
          </v-btn>
          <v-btn icon
                 class="menubar__button"
                 @click="commands.horizontal_rule"
          >
            <v-icon>remove</v-icon>
          </v-btn>
          <v-btn icon
                 class="menubar__button"
                 :class="{ 'is-active': isActive.bullet_list() }"
                 @click="commands.bullet_list"
          >
            <v-icon>format_list_bulleted</v-icon>
          </v-btn>

          <v-btn icon
                 class="menubar__button"
                 :class="{ 'is-active': isActive.ordered_list() }"
                 @click="commands.ordered_list"
          >
            <v-icon>format_list_numbered</v-icon>
          </v-btn>
          <v-btn icon
                 class="menubar__button"
                 @click="commands.undo"
          >
            <v-icon>undo</v-icon>
          </v-btn>
          <v-btn icon
                 class="menubar__button"
                 @click="commands.redo"
          >
            <v-icon>redo</v-icon>
          </v-btn>
          <v-dialog v-model="dialog" width="800">
            <v-btn icon slot="activator">
              <v-icon>image</v-icon>
            </v-btn>

            <v-card>
              <v-card-title>
                <h2>
                  Kép beillesztés
                </h2>
              </v-card-title>
              <v-form>
                <v-container>
                  <v-layout row wrap>
                    <v-flex xs6>
                      <v-text-field
                        v-model="image.title"
                        label="Kép leirás"
                      ></v-text-field>
                    </v-flex>
                    <v-flex xs6>
                      <v-text-field
                        v-model="image.alt"
                        label="Kép alt szöveg"
                      ></v-text-field>
                    </v-flex>
                    <v-flex xs4>
                      <v-checkbox
                        color="red"
                        v-model="image.fix_width"
                        label="Fix szélesség"
                      ></v-checkbox>
                    </v-flex>
                    <v-flex xs8>
                      <v-slider
                        color="red"
                        max="800"
                        inverse-label
                        v-model="image.width"
                        v-bind:label="image.width+'px'"
                      >
                      </v-slider>
                    </v-flex>
                    <v-flex xs4>
                      <v-checkbox
                        color="red"
                        v-model="image.fix_height"
                        label="Fix magasság">
                      </v-checkbox>
                    </v-flex>
                    <v-flex xs8>
                      <v-slider
                        color="red"
                        inverse-label
                        max="400"
                        v-model="image.height"
                        v-bind:label="image.height+'px'"
                      ></v-slider>
                    </v-flex>
                    <v-flex xs12 text-sx-center>
                      <v-radio-group v-model="image.align" row>
                        <v-radio
                          color="red"
                          label="Igazítás balra"
                          value="content-image-left">
                        </v-radio>
                        <v-radio
                          color="red"
                          label="Igazítás középre"
                          value="content-image-center">
                        </v-radio>
                        <v-radio
                          color="red"
                          label="Igazítás jobbra"
                          value="content-image-right">
                        </v-radio>
                      </v-radio-group>
                    </v-flex>
                    <v-flex
                      xs12
                      class="text-xs-center text-sm-center text-md-center text-lg-center"
                    >
                      <img :src="image.url" height="250" v-if="image.url"/>
                      <v-text-field
                        label="Kép kiválasztása"
                        @click='pickFile'
                        v-model='image.name'
                        prepend-icon='attach_file'></v-text-field>
                      <input
                        type="file"
                        style="display: none"
                        ref="image"
                        accept="image/*"
                        @change="onFilePicked"
                      >
                    </v-flex>
                  </v-layout>
                </v-container>
              </v-form>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn @click=" cancelInsertImage()
                      ">Mégsem
                </v-btn>
                <v-btn
                  color="success"
                  @click="insertImage(commands.image_ext)"
                >
                  Beillesztés
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

        </div>
      </editor-menu-bar>
      <editor-content id="my-editor" :editor="editor"/>

      <!--<div class="meta">-->
      <!--<p>Létrehozva: <span>{{createdAt}}</span></p>-->
      <!--<p>Utolsó frissítés: <span>{{updatedAt}}</span></p>-->
      <!--</div>-->

      <v-btn to="/admin/posts">Mégsem</v-btn>
      <v-btn
        @click="sendToServer()"
        color="success"
        :disabled="!valid"
      >Mentés
      </v-btn>
    </v-form>
  </div>
</template>

<script>
import axios from 'axios';
import { Editor, EditorContent, EditorMenuBar } from 'tiptap';
import {
  Bold, Italic, Strike, Underline, Heading,
  BulletList, OrderedList, ListItem, TodoItem, TodoList,
  HorizontalRule, History,
} from 'tiptap-extensions';
import ImageExtension from '../../lib/image-extension';

export default {
  name: 'Post',
  components: {
    EditorContent,
    EditorMenuBar,
  },
  data() {
    return {
      valid: true,
      active: true,
      thumbnail_dialog: false,
      thumbnail: {
        url: '',
        name: '',
        file: '',
      },
      image: {
        align: 'content-image-left',
        url: '',
        name: '',
        file: '',
        width: 400,
        height: 0,
        alt: '',
        title: '',
        fix_width: true,
        fix_height: false,
      },
      dialog: false,
      html: '',
      editor: new Editor({
        extensions: [
          new Bold(),
          new Italic(),
          new Strike(),
          new Underline(),
          new Heading({ levels: [1, 2, 3] }),
          new BulletList(),
          new OrderedList(),
          new ListItem(),
          new TodoItem(),
          new TodoList(),
          new HorizontalRule(),
          new History(),
          new ImageExtension(),
        ],
        onUpdate: ({ getHTML }) => {
          this.html = getHTML();
          this.post.attributes.content = getHTML();
        },
      }),
      post: {
        id: 0,
        attributes: {
          title: '',
          blurb: '',
          content: '',
          thumbnail_url: '',
        },
      },
    };
  },
  methods: {
    insertImage(command) {
      const apiUrl = 'http://206.189.55.142/api/';
      // console.log(this.image.file);

      const formData = new FormData();
      formData.append('image', this.image.file);

      axios.post(
        `${apiUrl}/embedded_image`,
        formData,
        {
          headers: {
            Authorization: `Bearer ${window.localStorage.getItem('user_token')}`,
            Accept: 'application/json',
            'Content-Type': 'multipart/form-data',
          },
        },
      ).then((res) => {
        console.log('SUCCESS!!');
        console.log(res.data.url);

        const commandOptions = {
          src: res.data.url,
          title: this.image.title,
          alt: this.image.alt,
          class: this.image.align,
        };
        if (this.image.fix_width) {
          commandOptions.width = `${this.image.width}`;
        }
        if (this.image.fix_height) {
          commandOptions.height = `${this.image.height}`;
        }
        console.log(commandOptions);
        command(commandOptions);
        this.dialog = false;
        this.image = {
          align: 'content-image-left',
          url: '',
          name: '',
          file: '',
          width: 400,
          height: 0,
          alt: '',
          title: '',
          fix_width: true,
          fix_height: false,
        };
      }).catch((err) => {
        console.log('FAILURE!!');
        console.log(err);
      });
    },
    addThumbnail() {
      console.log('add thumb');
      this.thumbnail_dialog = false;
      const apiUrl = 'http://206.189.55.142/api/';
      const formData = new FormData();
      formData.append('image', this.thumbnail.file);

      axios.post(
        `${apiUrl}/thumbnail`,
        formData,
        {
          headers: {
            Authorization: `Bearer ${window.localStorage.getItem('user_token')}`,
            Accept: 'application/json',
            'Content-Type': 'multipart/form-data',
          },
        },
      ).then((res) => {
        console.log('SUCCESS!!');
        console.log(res.data.url);
        this.post.attributes.thumbnail_url = res.data.url;
        this.thumbnail = {
          url: '',
          name: '',
          file: '',
        };
      }).catch((err) => {
        console.log('FAILURE!!');
        console.log(err);
      });
    },
    cancelInsertImage() {
      this.dialog = false;
      this.thumbnail_dialog = false;
    },
    pickFile() {
      this.$refs.image.click();
    },
    pickThumbnail() {
      this.$refs.thumbnail.click();
    },
    onFilePicked(e) {
      console.log('file picked');
      const { files } = e.target;
      if (files[0] !== undefined) {
        this.image.name = files[0].name;
        if (this.image.name.lastIndexOf('.') <= 0) {
          this.image.name = '';
          return;
        }
        const fr = new FileReader();
        fr.readAsDataURL(files[0]);
        fr.addEventListener('load', () => {
          this.image.url = fr.result;
          [this.image.file] = files; // this is an image file that can be sent to server...
        });
      } else {
        this.image.name = '';
        this.image.file = '';
        this.image.url = '';
      }
    },
    onFilePickedThumbnail(e) {
      console.log('Thumbnail file picked');
      const { files } = e.target;
      if (files[0] !== undefined) {
        this.thumbnail.name = files[0].name;
        if (this.thumbnail.name.lastIndexOf('.') <= 0) {
          this.thumbnail.name = '';
          return;
        }
        const fr = new FileReader();
        fr.readAsDataURL(files[0]);
        fr.addEventListener('load', () => {
          this.thumbnail.url = fr.result;
          [this.thumbnail.file] = files; // this is an image file that can be sent to server...
        });
      } else {
        this.thumbnail.name = '';
        this.thumbnail.file = '';
        this.thumbnail.url = '';
      }
    },
    sendToServer() {
      const apiUrl = 'http://206.189.55.142/api/';

      const data = {
        type: 'posts',
        attributes: {
          title: this.post.attributes.title,
          blurb: this.post.attributes.blurb,
          content: this.post.attributes.content,
          thumbnail_url: this.post.attributes.thumbnail_url,
        },
      };

      console.log(data);
      if (this.post.id === 0) {
        // console.log('create new post');
        axios.post(
          `${apiUrl}posts`,
          { data },
          {
            headers: {
              Authorization: `Bearer ${window.localStorage.getItem('user_token')}`,
              Accept: 'application/vnd.api+json',
              'Content-Type': 'application/vnd.api+json',
            },
          },
        ).then(() => {
          this.$router.push('/admin/posts');
        }).catch((res) => {
          console.log(res.data);
        });
      } else {
        axios.patch(
          `${apiUrl}posts/${this.post.id}`,
          { data },
          {
            headers: {
              Authorization: `Bearer ${window.localStorage.getItem('user_token')}`,
              Accept: 'application/vnd.api+json',
              'Content-Type': 'application/vnd.api+json',
            },
          },
        ).then(() => {
          this.$router.push('/admin/posts');
        }).catch((res) => {
          console.log(res.data);
        });
      }
    },
  },
  computed: {
    createdAt() {
      return new Date(this.post.attributes.created_at).toLocaleString('hu-HU');
    },
    updatedAt() {
      return new Date(this.post.attributes.updated_at).toLocaleString('hu-HU');
    },
  },
  mounted() {
    if (this.$route.name === 'admin-post-new') {
      // console.log('new');
    } else {
      axios
        .get(`http://206.189.55.142/api/posts/${this.$route.params.id}`)
        .then((response) => {
          this.post = response.data.data;
          this.editor.setContent(response.data.data.attributes.content);
        });
    }
  },
  beforeDestroy() {
    this.editor.destroy();
  },
};
</script>

<style lang="scss" scoped>
  #post-edit {
    max-width: 1320px;
    margin: 60px auto;
  }
</style>
