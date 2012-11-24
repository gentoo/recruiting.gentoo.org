# See http://lostechies.com/derickbailey/2011/09/15/zombies-run-managing-page-transitions-in-backbone-apps/
Backbone.View.prototype.close = ->
  #@remove()
  @unbind()
  @onClose() if @onClose?

window.Gentoo =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    Backbone.history.start()

    #$(document).ready ->
    #  Gentoo.initialize()
