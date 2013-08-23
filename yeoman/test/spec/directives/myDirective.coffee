'use strict'

describe 'Directive: myDirective', () ->

  # load the directive's module
  beforeEach module 'yeomanApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<my-directive></my-directive>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the myDirective directive'
