var assert = require('assert');
var sinon = require('sinon');
/**
 *
 */
var outerFn = function outerFn(fn) {
    fn();
};

var obj;

describe('anonymous spies', function () {
    it('should be called', function () {
        var spy = sinon.spy();

        outerFn(spy);

        assert.equal(spy.calledOnce, true);
    });

});

describe('spies that hijack another function', function () {
    beforeEach(function () {
        obj = {
            method1: function (arg1) {
                obj.fnToSpy.apply(null, [arg1]);
            },
            fnToSpy: function () {

            }
        };
    });
    afterEach(function () {
        obj.fnToSpy.restore(); //Un-hijack
    });

    it('should be called', function () {
        var spy = sinon.spy(obj, 'fnToSpy'); //hijack obj.fnToSpy()

        obj.method1(); // simply triggers call to fnToSpy

        assert.equal(spy.calledOnce, true);
        assert.equal(obj.fnToSpy.calledOnce, true);  // NB. object.fnToSpy === spy
    });

    it('obj.fnToSpy.withArgs()', function () {
        sinon.spy(obj, 'fnToSpy'); // creates the base spy
        obj.fnToSpy.withArgs('arg1'); // creates an arg-specific spy

        assert.equal(obj.fnToSpy.withArgs('arg1').calledOnce, false);

        obj.method1('arg1');
        assert.equal(obj.fnToSpy.withArgs('arg1').calledOnce, true);
    });

    it('obj.fnToSpy.withArgs("arg1") - fnToSpy should be called with only 1 argument', function () {
        sinon.spy(obj, 'fnToSpy');

        obj.fnToSpy.withArgs('arg1');
        obj.fnToSpy.withArgs('arg1', 'arg2');

        // Test -ve (2 args)
        obj.method1('arg1', 'arg2');
        assert.equal(obj.fnToSpy.withArgs('arg1', 'arg2').calledOnce, false);

        // Test +ve (1 arg)
        obj.method1('arg1');
        // The callCount == 2 because we called with 'arg1' in the -ve test above!
        assert.equal(obj.fnToSpy.withArgs('arg1').callCount, 2);
    });


        // spy.returned(o), true
        // spy.threw(), true

});