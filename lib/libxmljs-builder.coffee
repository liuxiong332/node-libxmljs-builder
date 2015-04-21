###
 node-libxmljs-builder
 https://github.com/liuxiong332/node-libxmljs-builder

 Copyright (c) 2015 liuxiong
 Licensed under the MIT license.
###
{Document, Element} = require 'libxmljs'

do ->
  Element.prototype[key] = value for key, value of require './element-extends'

class ChildrenBuilder
  constructor: (@xmlBuilder, @doc) ->
    @childrens = []

  forEach: (callback) -> @childrens.forEach callback

  node: (name, attrs, content) ->
    @nodeNS(null, name, attrs, content)

  _newElement: (name) -> new Element @doc, name

  nodeNS: (ns, name, attrs, content) ->
    if(typeof attrs isnt 'object')
      content = attrs
      attrs = null

    element = @_newElement name
    element.attr(attrs) if attrs?
    element.namespace @xmlBuilder.getNS(ns) if ns?

    if typeof content is 'function'
      childrenBuilder = new ChildrenBuilder(@xmlBuilder, @doc)
      content.call(@xmlBuilder, childrenBuilder)
      childrenBuilder.forEach (node) ->
        element.addChild node
    else if content?
      element.text(content)

    @childrens.push element
    element

module.exports =
class XmlBuilder extends ChildrenBuilder
  constructor: ->
    @doc = new Document()
    @namespaces = {}
    super this, @doc

  _addNS: (key, href) ->
    @namespaces[key] = href

  # define namespaces in this builder
  #
  # @param [Object|String] key-href objects that map key to specific href
  defineNS: (nsObj, href) ->
    if arguments.length is 2
      @_addNS nsObj, href
    else
      @_addNS(key, href) for key, href of nsObj

  getNS: (key) -> @namespaces[key]

  _newElement: (name) ->
    element = new Element @doc, name
    for prefix, href of @namespaces
      @namespaces[prefix] = element.defineNamespace(prefix, href)
    element

  root: (name, attrs, content) ->
    element = @node name, attrs, content
    @doc.root element
    @doc

  rootNS: ->
    element = @nodeNS.apply(this, arguments)
    @doc.root element
    @doc
