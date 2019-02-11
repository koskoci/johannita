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
            :type="show1 ? 'text' : 'password'"
            name="password"
            label="Jelszó"
            counter
            @click:append="show1 = !show1"
          ></v-text-field>
        </v-flex>
        <v-flex xs12 text-xs-center>
          <v-btn
            align-self-center
            :disabled="!valid"
            color="success"
            @click="login"
          >
            Bejelentkezés
          </v-btn>
        </v-flex>
      </v-form>
    </v-layout>
    <v-layout align-center justify-center column>
      <v-btn
        align-self-center
        color="success"
        to="/regisztracio"
      >
        Regisztráció
      </v-btn>
    </v-layout>
  </v-container>
</template>

<script>
import axios from 'axios';

export default {
  name: 'Login',
  data: () => ({
    valid: true,
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
    login() {
      const apiUrl = 'http://206.189.55.142/api/';
      const url = `${apiUrl}auth?user=${this.email}&password=${this.password}`;
      axios.post(
        url,
        null,
        {
          headers: {
            Accept: 'application/json',
            'Content-Type': 'multipart/form-data',
          },
        },
      ).then(
        (res) => {
          const { token } = res.data;
          console.log(token);
          if (token) {
            window.localStorage.setItem('user_email', this.email);
            window.localStorage.setItem('user_token', token);
            window.location.href = '/';
          }
        },
      ).catch();
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
