const apiUrl = 'http://206.189.55.142/';

const get = (url, fallback) => {
  return fetch(`${apiUrl}${url}`, {
    method: 'GET',
    headers: new Headers({
      'Authorization': `Bearer ${window.localStorage.getItem('token')}`,
      'Accept': 'application/json'
    })
  }).then((res) => {
    if (res.status !== 200) return { data: fallback };

    return res.json();
  });
}

const post = (url, data) => {
  return fetch(`${apiUrl}${url}`, {
    method: 'POST',
    headers: new Headers({
      'Authorization': `Bearer ${window.localStorage.getItem('token')}`,
      'Accept': 'application/json',
      'Content-Type': 'application/vnd.api+json'
    }),
    body: JSON.stringify({ data })
  }).then((res) => {
    console.log(res);
  });
}

export const getProfile = () => get('users/me', null).then(res => res.data);
export const getPost = (id) => get(`posts/${id}`, null).then(res => res.data);
export const getPosts = () => get('posts', []).then(res => res.data);
export const getUsers = () => get('users', []).then(res => res.data);
export const getEvents = () => get('events', []).then(res => res.data);
export const getCourseCategories = () => get('course_categories', []).then(res => res.data);
export const getCourseEvents = () => get('course_events', []).then(res => res.data);

export const auth = (user, pass) => {
  return fetch(`${apiUrl}auth?user=${user}&password=${pass}`, {
    method: 'POST',
    mode: 'cors',
    cache: 'no-cache',
    headers: new Headers({
      'Content-Type': 'application/json'
    }),
  })
  .then(response => {
    if (response.status === 200) {
      response.json().then((data) => {
        window.localStorage.setItem('userName',user);
        window.localStorage.setItem('token', data.token);
        window.location.reload();
      });
    } else {
      return false;
    }
  });
}

export const register = (attributes) => {
  return post('users', {
    type: 'users',
    attributes
  });
}

export const signOut = () => {
  window.localStorage.removeItem('userName');
  window.localStorage.removeItem('token');
  window.location.replace('/');
}
