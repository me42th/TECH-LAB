var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var Person = /** @class */ (function () {
    function Person(name) {
        this.name = name;
        console.log(this.name);
    }
    Person.prototype.isFree = function () {
        return true;
    };
    return Person;
}());
var Employee = /** @class */ (function (_super) {
    __extends(Employee, _super);
    function Employee(id, name) {
        var _this = _super.call(this, name) || this;
        _this.id = id;
        console.log(_this.id);
        return _this;
    }
    Employee.prototype.isFree = function () {
        return false;
    };
    return Employee;
}(Person));
var Child = /** @class */ (function (_super) {
    __extends(Child, _super);
    function Child(name) {
        return _super.call(this, name) || this;
    }
    Child.prototype.isFree = function () {
        return true;
    };
    return Child;
}(Person));
var job = new Employee(42, 'David Meth');
var chil = new Child('Murilo');
console.log(job.isFree());
console.log(chil.isFree());
