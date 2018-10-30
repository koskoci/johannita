import { post } from './api';

export const login = (user, pass) => {
  return post(`auth?user=${user}&password=${pass}`, null)
  .then(res => res.json())
  .then(res => {
    if (res.token) {
      window.localStorage.setItem('userName',user);
      window.localStorage.setItem('token', res.token);
      window.location.href = '/';
    } else {
      return false;
    }
  });
}

export const register = (attributes) => {
  return post('users', {
    type: 'users',
    attributes
  }).then(res => {
    return res.error ? false : true;
  });
}

export const logout = () => {
  window.localStorage.removeItem('userName');
  window.localStorage.removeItem('token');
  window.location.replace('/');
}
