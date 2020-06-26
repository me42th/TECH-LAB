var dev = {
    name: 'David Meth',
    getJob: function () {
        return 'Programmer';
    }
};
var enf = {
    name: 'Brenda Costa',
    getJob: function () {
        return 'Nurse';
    }
};
var Doctor = /** @class */ (function () {
    function Doctor(name) {
        this.name = name;
    }
    Doctor.prototype.getJob = function () {
        return 'Doctor';
    };
    return Doctor;
}());
function display(worker) {
    console.log(worker.getJob());
}
var doc = new Doctor('Murilo Costa');
display(dev);
display(enf);
display(doc);
