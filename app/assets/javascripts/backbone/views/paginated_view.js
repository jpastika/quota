PaginatedView = Backbone.View.extend({
  initialize: function() {
    _.bindAll(this, 'previous', 'next', 'render');
    this.collection.bind('reset', this.render);
  },

  events: {
    'click a.prev': 'previous',
    'click a.next': 'next'
  },

  render: function() {
    this.el.html(app.templates.pagination(this.collection.pageInfo()));
  },

  previous: function() {
    this.collection.previousPage();
    return false;
  },

  next: function() {
    this.collection.nextPage();
    return false;
  }
});