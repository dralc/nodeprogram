
# node support
See the node support for harmony using `node --v8-options | grep harmony`

# destructuring
Quickly creates variables out of array and object values

```javascript
var [a,b,c] = ['one', 'two', 'three']       // gives you
var a='one';   var b='two';   var c='three'
```

# let, const
`let` gives you block scope for variables

`const` gives you protection against reference re-assignment

# spread
1. For spreading out an array argument across a functions arguments

    ```javascript
    function myFn(arg1, arg2, arg3) {
    }
    
    var ar = [1, 2, 3]
    
    myFn(...ar)  // gives arg1==1, arg2==2, arg3==3
    ```

1. Used with destructuring

    ```javascript
    var [a, b, ...theRest] = [1, 2, 3, 4]  // gives theRest === [3, 4]
    ```

1. To merge collections

    ```javascript
    var ar = [1, 2, 3]
    var expandedAr = ['a', 'b', ...ar, 'c']  // gives ['a', 'b', 1, 2, 3, 'c']
    ```

# arrow functions
1. Best for inline functions with single line returns

    ```javascript
    myAr.filter(function (obj) {
        return obj.value <= 15;
    });
    ```
    
    becomes
    ```javascript
    myAr.filter( obj => obj.value <= 15 );
    ```
    
    
    _Reasoning_
    
    1. It removes the most boiler plate in this shorthand syntax
    1. The logic in the function can't be directly unit tested (arrow functions are always anonymous)
     so it should be really simple. 
    
2. `this` will now be assigned to the parent context. Previously, `this` would vary based on 3 factors:

    > From [MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions) 
    Until arrow functions, every new function defined its own this value (a new object in case of a constructor, undefined in strict mode function calls, the context object if the function is called as an "object method", etc.). This proved to be annoying with an object-oriented style of programming.


# Template literals
1. Provides variable interpolation in strings

    ```javascript
    var var1 = 'jumped'
    var var2 = 'fence'
    
    console.log(`The fox ${var1} over the ${var2}`)
    ```
    
# Classes
1. Keywords used: `use strict, class, constructor get, extends, super`

```javascript
"use strict";

class Person {
    constructor (options={}) {
        this.name = options.name;
        this.sex = options.sex;
        this.all = options;
    }

    get all_details() {
        return this.all;
    }
}

class Tourist extends Person {
    constructor (options={}) {
        super(options);
        this.budget = options.budget;
        this.interests = options.interests;
    }

    get recommendations() {
        return ['luxury hotel', 'VIP shopping'];
    }
}

var someone = new Tourist({name: 'Al', sex: 'male', budget: 888, interests: ['shopping', 'relax']});

console.log(someone.all_details); // returns all Tourist fields
console.log(`--> We highly recommend these for your trip: ${someone.recommendations}`);    
```

# Symbols
1. Are unique values used as object keys

```javascript
mySym = Symbol('some important flag');
myObj[mySym] = true;  // Will not accidently overwrite another property
```

\> [More details](https://hacks.mozilla.org/2015/06/es6-in-depth-symbols/)


```javascript
typeof Symbol() == 'symbol'
Symbol.for(string)  // Get symbol from symbol registry shared across webpages
```

# References
1. https://courses.nodecasts.io/courses/javascript-es6
1. http://node.green (ES6 compatibility in nodejs)
1. https://hacks.mozilla.org/2015/06/es6-in-depth-symbols/