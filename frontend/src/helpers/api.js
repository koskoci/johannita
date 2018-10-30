const apiUrl = 'http://206.189.55.142/api/';

const parseGetResponse = (res) => {
  if (res.status === 200)
    return res.json().then(data => data.data);
}

const getHeaders = (opts) => new Headers({
  'Authorization': `Bearer ${window.localStorage.getItem('token')}`,
  'Accept': 'application/json',
  'Content-Type': opts && opts.multipart ? 'multipart/form-data' : 'application/vnd.api+json'
});

const query = (method, url, data) => {
  return fetch(`${apiUrl}${url}`, {
    method,
    headers:  getHeaders(),
    body: data ? JSON.stringify({ data }) : null
  }).then(res => res);
}

export const get = (url) => query('GET', url);
export const post = (url, data) => query('POST', url, data);
export const patch = (url, data) => query('PATCH', url, data);
export const destroy = (url) => query('DELETE', url);

const uploadFile = (url, data) => {
  const formData = new FormData();

  formData.append('attachment', data);

  return fetch(`${apiUrl}${url}`, {
    method: 'POST',
    headers:  getHeaders({ multipart: true }),
    body: formData
  }).then(res => res);
}

export const getPage = (id) => get(`page/${id}`).then(parseGetResponse);
export const getProfile = () => get('users/me').then(parseGetResponse);
export const getPost = (id) => get(`posts/${id}`).then(parseGetResponse);
export const getPosts = () => get('posts').then(parseGetResponse);
export const getUsers = () => get('users').then(parseGetResponse);
export const getCourses = () => get('courses').then(parseGetResponse);
export const getCourseCategories = () => get('course_categories').then(parseGetResponse);
export const getCourseEvents = () => get('course_events').then(parseGetResponse);

export const updateProfile = (attributes) => patch('users/me', { type: 'users', attributes }).then(res => res.data);
export const updatePost = (id, attributes) => patch(`posts/${id}`, { type: 'posts', attributes });

export const createPost = (attributes) => post('posts', { type: 'posts', attributes });

export const deletePost = (id) => destroy(`posts/${id}`).then(res => res);

export const uploadImageToPost = (id, data) => uploadFile(`posts/${id}/images`, data);
