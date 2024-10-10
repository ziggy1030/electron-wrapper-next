(function () {
    'use strict';

    const origin = HTMLElement.prototype.requestPointerLock
    HTMLElement.prototype.requestPointerLock = function () {
        return origin.call(this)
    }
})();