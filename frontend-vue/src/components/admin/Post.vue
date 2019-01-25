<template>
  <div id="post-edit">
    <v-form>
      <v-text-field
        v-model="post.attributes.title"
        :counter="100"
        label="Title"
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
            @click="showImagePrompt(commands.image)"
          >
            <v-icon>image</v-icon>
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
          <v-dialog
            v-model="dialog"
            width="500"
          >
            <v-btn icon
              slot="activator"
              color="red lighten-2"
              dark
            >
              <v-icon>image</v-icon>
            </v-btn>

            <v-card>
              <v-card-title
                class="headline grey lighten-2"
                primary-title
              >
                Privacy Policy
              </v-card-title>

              <v-card-text>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
                nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                uis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore
                eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt
                in culpa qui officia deserunt mollit anim id est laborum.
              </v-card-text>

              <v-divider></v-divider>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                  color="primary"
                  flat
                  @click="insertImage(commands.image)"
                >
                  I accept
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

        </div>
      </editor-menu-bar>
      <editor-content :editor="editor" />

      <div class="meta">
        <p>Létrehozva: <span>{{createdAt}}</span></p>
        <p>Utolsó frissítés: <span>{{updatedAt}}</span></p>
      </div>
      <v-btn color="success">Mentés</v-btn>
    </v-form>

    <div>
      {{html}}
    </div>


  </div>
</template>

<script>
import axios from 'axios';
import { Editor, EditorContent, EditorMenuBar } from 'tiptap';
import {
  Bold, Italic, Strike, Underline, Heading,
  BulletList, OrderedList, ListItem, TodoItem, TodoList,
  HorizontalRule, History, Image,
} from 'tiptap-extensions';

export default {
  name: 'Post',
  components: {
    EditorContent,
    EditorMenuBar,
  },
  data() {
    return {
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
          new Image(),
        ],
        content: `
          <h1>Yay Headlines!</h1>
          <p>All these <strong>cool tags</strong> are working now.</p>
        `,
        onUpdate: ({ getHTML }) => {
          this.html = getHTML();
        },
      }),
      post: {
        id: 0,
        attributes: {
          title: '',
        },
      },
    };
  },
  methods: {
    insertImage(command) {
      this.dialog = false;
      const src = 'http://zoltan.pro/static/logo.png';
      const title = 'imagetitle';
      const alt = 'alt sentence';
      console.log(command);
      command({ src, title, alt });
      return null;
    },
    showImagePrompt() {
      this.dialog = true;
      // if (src !== null) {
      //   command({ src });
      // }
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
    axios
      .get(`http://206.189.55.142/api/posts/${this.$route.params.id}`)
      .then((response) => {
        // console.log(response.data.data);
        this.post = response.data.data;
      });
  },
  beforeDestroy() {
    this.editor.destroy();
  },
};
</script>

<style scoped>
  #post-edit {
    max-width: 1320px;
    margin: 60px auto;
  }
  img {
    height: 50px;
    max-height: 50px;
  }
</style>
