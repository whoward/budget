//= require handlebars

window.Template = {
  compile: function(template) {
    return Handlebars.compile(template);
  },

  embedded: function(id) {
    var node = document.getElementById(id);

    if(node) {
      return this.compile(node.innerHTML);
    } else {
      throw "unable to find a template with ID '" + id + "'";
    }
  }
};
