
Builder = require '../lib/libxmljs-builder'
assert = require 'should'
util = require 'util'

describe 'libxmljsBuilder', ->

  it 'should create document with text content', ->
    builder = new Builder
    doc = builder.root('hello', {attrA: 'valA', attrB: 'valB'}, 'text')
    doc.root().name().should.equal 'hello'
    doc.root().attr('attrA').value().should.equal 'valA'
    doc.root().attr('attrB').value().should.equal 'valB'
    doc.root().text().should.equal 'text'

  # it 'define namespaces', ->
  #   builder = new Builder
  #   builder.defineNS {nsA: 'namespaceA', nsB: 'namespaceB'}
  #   builder.defineNS 'nsC', 'namespaceC'
  #   builder.getNS('nsA').should.equal 'namespaceA'
  #   builder.getNS('nsC').should.equal 'namespaceC'
  #
  #   doc = builder.rootNS('hello', builder.getNS('nsA'), 'text')
  #   util.log doc.toString()

  it 'create document and child nodes', ->
    xmlBuilder = new Builder
    doc = xmlBuilder.root 'root', {attrA: 'valA'}, (builder) ->
      builder.node 'nodeA', {attrB: 'valB'}, 'textA'

    util.log doc.toString()
    doc.root().name().should.equal 'root'
    doc.root().attr('attrA').value().should.equal 'valA'

    doc.childNodes().length.should.equal 1
    childNode = doc.childNodes()[0]
    childNode.name().should.equal 'nodeA'
    childNode.attrs().length.should.equal 1
    childNode.attr('attrB').value().should.equal 'valB'
    childNode.text().should.equal 'textA'

  it 'create NS document and child nodes', ->
    xmlBuilder = new Builder
    xmlBuilder.defineNS {nsA: 'namespaceA', nsB: 'namespaceB'}
    doc = xmlBuilder.rootNS 'root', xmlBuilder.getNS('nsA'), (builder) ->
      builder.nodeNS 'nodeA', xmlBuilder.getNS('nsA'), 'textA'
    util.log doc.toString()
