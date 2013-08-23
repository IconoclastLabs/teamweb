'use strict';

angular.module('teamwebApp')
  .directive 'ngMedium', [->
    restrict: 'EA'
    replace: true
    transclude: true
    # scope: {
    #   placeholder: "=mediumPlaceholder"
    # }
    template: '<div>
                 <div>Placeholder: {{$attr.mediumPlaceholder}}</div>
    					   <div><span ng-transclude></span></div>
    					 </div>'
    link: (scope, element, attrs) ->
    	#console.log scope, element, attrs
    	placeholderElement = angular.element(element.children().eq(0))
    	contentElement = angular.element(element.children().eq(1))
    	console.log placeholderElement
    	#scope.placeholder = attrs.placeHolder
    #  element.text 'this is the directive'
  ]

  # .directive 'ngMedium', [->
  #   template: '<div>asdfsdf</div>'
  #   restrict: 'E'
  #   #link: (scope, element, attrs) ->
  #   #  element.text 'this is the myDirective directive'
  # ]
