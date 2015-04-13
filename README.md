# node-libxmljs-builder
[![NPM version][npm-image]][npm-url] [![Build Status][travis-image]][travis-url] [![Dependency Status][daviddm-image]][daviddm-url] [![Coverage Status][coveralls-image]][coveralls-url]

the xml builder that wrap libxmljs


## Install

```bash
$ npm install --save libxmljs-builder
```


## Usage

### Create document and child nodes

```javascript
var Builder = require('libxmljs-builder');
var xmlBuilder = new Builder
var doc = xmlBuilder.root('root', {attrA: 'valA', attrB: 'valB'}, function(builder) {
  builder.node('nodeA', {attrC: 'valC'}, 'nodeText')
});
console.log(doc.toString());
```
that will generate following xml:
```xml
<root attrA="valA" attrB="valB">
  <nodeA attrC="valC">nodeText<nodeA>
</root>
```

### create document with nameapce

```javascript
var Builder = require('libxmljs-builder');
var xmlBuilder = new Builder
xmlBuilder.defineNS {nsA: 'namespaceA', nsB: 'namespaceB'}
var doc = xmlBuilder.rootNS('nsA', 'root', {attrA: 'valA', attrB: 'valB'}, function(builder) {
  builder.nodeNS('nsB', 'nodeA', {attrC: 'valC'}, 'nodeText')
});
console.log(doc.toString());
```
that will generate the following xml:
```xml
<nsA:root xmlns:nsA="namespaceA" xmlns:nsB="namespaceB" xmlns:nsC="namespaceC" attrA="valA" attrB="valB">
  <nsB:nodeA attrC="valC">nodeText</nsB:nodeA>
</nsA:root>
```

## API

### class XmlBuilder

**Methods**

  * `defineNS(nsobj, href)`

    define the namespaces that xml need to use
    * `nsObj` **Object|String**

      if is String, it is the namespace prefix, else it's the prefix-href of namespace

    * `href` **String**

      namespace href, it's valid only if nsObj is String

    * `return` **Namespace**

      [the libxmljs Namespace Object](https://github.com/polotek/libxmljs/wiki/Namespaces)

  * `getNS(prefix)`

    get the namespace object
    * `prefix` **String**

      the namespace's prefix

    * `return` **Namespace**
  * `root(name, attrs, content)`

    set the root element

    * `name` **String**

      the element's name

    * `attrs` **Object**

      key-value of attribute list

    * `content` **String|Function**

      if content is String, then it's element's text. if is Function, it can add children node in this function. The function's signature is `function(builder)`, when `builder` is `ChildrenBuilder` type.

    * `return` **Document**

      [The libxmljs Document class](https://github.com/polotek/libxmljs/wiki/Document).

  * `rootNS(ns, name, attrs, content)`

    set the root element with namespace

    * `ns` **String**

      the namespace prefix. Other parameters are the same with the `root(name, attrs, content)` method.

### class ChildrenBuilder

**Methods**

  * `node(name, attrs, content)`

  define the new element. The parameters and return value is the same with `root(name, attrs, content)`.

  * `nodeNS(ns, name, attrs, content)`

  define new element with namespace. The parameters and return value is the same with `rootNS(ns, name, attrs, content)`.

## Contributing

In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [gulp](http://gulpjs.com/).


## License

Copyright (c) 2015 liuxiong. Licensed under the MIT license.



[npm-url]: https://npmjs.org/package/node-libxmljs-builder
[npm-image]: https://badge.fury.io/js/node-libxmljs-builder.svg
[travis-url]: https://travis-ci.org/liuxiong332/node-libxmljs-builder
[travis-image]: https://travis-ci.org/liuxiong332/node-libxmljs-builder.svg?branch=master
[daviddm-url]: https://david-dm.org/liuxiong332/node-libxmljs-builder
[daviddm-image]: https://david-dm.org/liuxiong332/node-libxmljs-builder.svg?theme=shields.io
[coveralls-url]: https://coveralls.io/r/liuxiong332/node-libxmljs-builder
[coveralls-image]: https://coveralls.io/repos/liuxiong332/node-libxmljs-builder/badge.png
