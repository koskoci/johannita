get = (url, fallback) => {
  return fetch(url, {
    method: 'GET',
    headers: new Headers({
      'Authentication': `Bearer ${localStorage.getItem('token')}`,
      'Content-Type': 'application/json; charset=utf-8'
    })
  }).then((res) => {
    if (res.status !== 200) return { data: fallback };

    return res.json();
  });
}

getPosts = () => {
  return get('http://206.189.55.142/posts.json', []).then((res) => {
    return res.data;
  });
}

auth = (user, pass) => {
  return fetch(`http://206.189.55.142/auth?user=${user}&password=${pass}`, {
    method: 'POST',
    mode: 'cors',
    cache: 'no-cache',
    headers: new Headers({
      'Content-Type': 'application/json; charset=utf-8',
    }),
  })
  .then(response => response.json())
  .catch(error => { return error; })
  .then(response => {
    if (response.error) return false;

    localStorage.setItem('userName',user);
    localStorage.setItem('token', response.token);
    window.location.reload();
  });
}

signOut = () => {
  localStorage.removeItem('userName');
  localStorage.removeItem('token');
  window.location.replace('/');
}

module.exports = {
  getPosts,
  auth,
  signOut
}
