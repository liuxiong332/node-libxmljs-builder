module.exports =
  attrVal: (key) ->
    @attr(key)?.value()

  attrVals: ->
    attrs = {}
    attrs[attrObj.name()] = attrObj.value() for attrObj in @attrs()
    attrs

  namespaceVal: ->
    @namespace().href()
