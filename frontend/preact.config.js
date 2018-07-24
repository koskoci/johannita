export default function (config, env, helpers) {
  const { plugin } = helpers.getPluginsByName(config, 'HtmlWebpackPlugin')[0] || {};

  if (plugin) {
    //console.log(helpers);
    helpers.setHtmlTemplate(config, 'src/index.html');
  }
}
