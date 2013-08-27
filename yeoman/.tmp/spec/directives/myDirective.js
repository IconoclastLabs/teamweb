(function() {
  'use strict';
  describe('Directive: myDirective', function() {
    var scope;
    beforeEach(module('yeomanApp'));
    scope = {};
    beforeEach(inject(function($controller, $rootScope) {
      return scope = $rootScope.$new();
    }));
    return it('should make hidden element visible', inject(function($compile) {
      var element;
      element = angular.element('<my-directive></my-directive>');
      element = $compile(element)(scope);
      return expect(element.text()).toBe('this is the myDirective directive');
    }));
  });

}).call(this);

/*
//@ sourceMappingURL=myDirective.js.map
*/