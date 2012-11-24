class Gentoo.Routers.Projects extends Backbone.Router
  initialize: (projects) ->
    @projects = new Gentoo.Collections.Projects(projects)
    @view = new Gentoo.Views.ProjectsIndex(collection: @projects)
    @view.render()
