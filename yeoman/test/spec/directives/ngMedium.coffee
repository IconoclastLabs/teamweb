'use strict'

describe 'Directive: ngMedium', () ->

  # load the directive's module
  beforeEach module 'teamwebApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<ng-medium></ng-medium>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the ngMedium directive'
