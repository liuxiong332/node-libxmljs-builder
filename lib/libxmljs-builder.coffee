###
 node-libxmljs-builder
 https://github.com/liuxiong332/node-libxmljs-builder

 Copyright (c) 2015 liuxiong
 Licensed under the MIT license.
###
{Document, Element} = require 'libxmljs'

class ChildrenBuilder
  constructor: (@xmlBuilder, @doc) ->
    @childrens = []

  forEach: (callback) -> @childrens.forEach callback

  node: (name, attrs, content) ->
    if(typeof attrs isnt 'object')
      content = attrs
      attrs = null

    element = new Element(@doc, name)
    element.attr(attrs) if attrs?

    if typeof content isnt 'function'
      element.text(content)
    else
      childrenBuilder = new ChildrenBuilder(@xmlBuilder, @doc)
      content.call(@xmlBuilder, childrenBuilder)
      childrenBuilder.forEach (node) ->
        element.addChild node
    @childrens.push element
    element

  nodeNS: (name, ns, attrs, content) ->
    console.log name + ':' + ns + ':' + attrs + ':' + content
    element = @node(name, attrs, content)
    element.namespace ns.key, ns.href
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

  getNS: (key) -> {key: key, href: @namespaces[key]}

  root: (name, attrs, content) ->
    element = @node name, attrs, content
    @doc.root element
    @doc

  rootNS: ->
    element = @nodeNS.apply(this, arguments)
    @doc.root element
    @doc
