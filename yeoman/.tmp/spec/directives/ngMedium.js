(function() {
  'use strict';
  describe('Directive: ngMedium', function() {
    var scope;
    beforeEach(module('teamwebApp'));
    scope = {};
    beforeEach(inject(function($controller, $rootScope) {
      return scope = $rootScope.$new();
    }));
    return it('should make hidden element visible', inject(function($compile) {
      var element;
      element = angular.element('<ng-medium></ng-medium>');
      element = $compile(element)(scope);
      return expect(element.text()).toBe('this is the ngMedium directive');
    }));
  });

}).call(this);

/*
//@ sourceMappingURL=ngMedium.js.map
*/