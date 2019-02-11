<template>
  <v-container>
    <v-layout align-center justify-center column fill-height>
      <v-form
        id="login-form"
        ref="form"
        v-model="valid"
      >
        <v-flex xs12>
          <v-text-field
            color="red"
            v-model="last_name"
            :rules="[v => !!v || 'megadása kötelező!']"
            name="last_name"
            validate-on-blur
            label="Vezetéknév"
            required
          ></v-text-field>
        </v-flex>
        <v-flex xs12>
          <v-text-field
            color="red"
            v-model="first_name"
            :rules="[v => !!v || 'megadása kötelező!']"
            name="first_name"
            validate-on-blur
            label="Keresztnév"
            required
          ></v-text-field>
        </v-flex>
        <v-flex xs12>
          <v-text-field
            color="red"
            v-model="email"
            :rules="emailRules"
            name="email"
            validate-on-blur
            label="E-mail"
            required
          ></v-text-field>
        </v-flex>
        <v-flex xs12>
          <v-text-field
            color="red"
            v-model="password"
            :append-icon="show1 ? 'visibility_off' : 'visibility'"
            :rules="passwordRules"
            :type="show1 ? 'text' : 'password'"
            name="password"
            label="Jelszó"
            counter
            @click:append="show1 = !show1"
          ></v-text-field>
        </v-flex>
        <v-checkbox
          v-model="checkbox"
          :rules="[v => !!v || '']"
          label="Elfogadom az adatvédelmi szabályzatot"
          required
        ></v-checkbox>
        <v-flex xs12 text-xs-center>
          <v-btn
            align-self-center
            :disabled="!valid"
            color="success"
            @click="register"
          >
            Regisztráció
          </v-btn>
        </v-flex>
      </v-form>
    </v-layout>

    <v-layout align-center justify-center column>
      <v-btn
        align-self-center
        color="success"
        to="/bejelentkezes"
      >
        Bejelentkezés
      </v-btn>
    </v-layout>
  </v-container>
</template>

<script>
import axios from 'axios';

export default {
  name: 'Registration',
  data: () => ({
    valid: true,
    checkbox: false,
    first_name: '',
    last_name: '',
    show1: false,
    password: '',
    passwordRules: [
      v => !!v || 'Jelszó megadása kötelező!',
      v => (v && v.length >= 8) || 'A jelszó minimum 8 karakter',
    ],
    email: '',
    emailRules: [
      v => !!v || 'E-mail megadása kötelező',
      v => /.+@.+/.test(v) || 'Hibás email formátum',
    ],
    // checkbox: false,
  }),
  methods: {
    register() {
      const attributes = {
        email: this.email,
        password: this.password,
        first_name: this.first_name,
        last_name: this.last_name,
      };

      const apiUrl = 'http://206.189.55.142/api/';
      const url = `${apiUrl}users`;
      axios.post(
        url,
        {
          type: 'users',
          attributes,
        },
        {
          headers: {
            Accept: 'application/json',
            'Content-Type': 'application/vnd.api+json',
          },
        },
      ).then(
        (res) => {
          console.log(res);
        },
      ).catch(
        (e) => {
          console.log(e);
        },
      );
    },
  },
};
</script>

<style lang="scss" scoped>
  #login-form {
    width: 300px;
    margin: 80px auto;

    button {
      margin: 20px;
    }
  }
</style>
