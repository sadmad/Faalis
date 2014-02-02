


var Datetime_ = angular.module("DatetimeField", ['ngQuickDate']);

/*
 * <string-field></string-field> directive defination
 */
Datetime_.directive('datetimeField', ["$filter", "gettext", function($filter, gettext) {

    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";
    }
    // Actual object of <string-field> directive
    return {
        templateUrl: template("fields/datetime/datetime"),
        replace: true,
        restrict: "E",
        transclude: true,
        scope: {
            cssClasses: '=cssClass',

            // fieldname
            field: "=fieldName",
            // Does this field is required
            required: "=",
            // Actual Angularjs ng-model
            model: '='
        },
        link: link
    };
}]);