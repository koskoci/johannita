loadPosts = () => {
  return fetch('http://206.189.55.142/posts.json').then((res) => {
    if (res.status !== 200) return {};

    return res.json().then((data) => {
      return data;
    });
  });
}

module.exports = {
  loadPosts
}
