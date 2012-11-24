class Gentoo.Views.ProjectsIndex extends Backbone.View
  template: JST['projects/index']
  alertTemplate: JST['shared/alert']
  el: "#projects"

  initialize: ->
    @subprojects = {}

  events:
    "click tr": "load_subprojects"

  render: ->
    @collection.each (prj) =>
      $(@el).append(@template(prj.toJSON()))
    this

  load_subprojects: (e)->
    node = $(e.currentTarget)
    projectId = node.attr("data-prjid")
    if (subs = @subprojects[projectId + ""])?
      subs.each (sub) =>
        if (subsubs = @subprojects[sub.id + ""])?
          subsubs.each (subsub) ->
            $("tr[data-prjid=" + subsub.id + "]").hide()
        $("tr[data-prjid=" + sub.id + "]").toggle()
    else
      @subprojects[projectId + ""] = new Gentoo.Collections.Projects
      @subprojects[projectId + ""].fetch(data: {parent_id: projectId}, success: @render_subprojects(node))
 
  render_subprojects: (prj) ->
    (prjs) =>
      if prjs.length is 0
        a = @alertTemplate(message: "No subjects found.")
        $(".page-header").before a
        $(".alert").fadeOut(2000)
      prjs.each (p) =>
        if prj.hasClass("sub-project")
          p.set("klazz", "sub-sub-project")
        else
          p.set("klazz", "sub-project")
        prj.after(@template(p.toJSON()))
