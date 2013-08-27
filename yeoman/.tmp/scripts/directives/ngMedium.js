(function() {
  'use strict';
  angular.module('teamwebApp').directive('ngMedium', [
    function() {
      return {
        restrict: 'EA',
        replace: true,
        transclude: true,
        template: '<div>\
                 <div>Placeholder: {{$attr.mediumPlaceholder}}</div>\
    					   <div><span ng-transclude></span></div>\
    					 </div>',
        link: function(scope, element, attrs) {
          var contentElement, placeholderElement;
          placeholderElement = angular.element(element.children().eq(0));
          contentElement = angular.element(element.children().eq(1));
          return console.log(placeholderElement);
        }
      };
    }
  ]);

}).call(this);

/*
//@ sourceMappingURL=ngMedium.js.map
*/