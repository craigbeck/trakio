(function() {

  var selector = '#new_project';

  Trakio.CreateProjectButtonView = Ember.View.extend({
    click: function() {
      Trakio.showForm(selector);
      return false;
    }
  });

  Trakio.ProjectNewView = Ember.View.extend({
    templateName: 'projects/new',

    submit: function() {
      var loading = document.createElement('div');
      loading.id = 'loading';
      $(event.target).append(loading);
      this.get('controller').addProject(this.get('nameField').get('value'));
      Trakio.hideForm(selector);
      return false;
    }
  });

  Trakio.ProjectNewCancelButtonView = Ember.View.extend({
    click: function() {
      Trakio.hideForm(selector);
      return false;
    }
  });

})();
