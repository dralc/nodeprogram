
# node support
See the node support for harmony using `node --v8-options | grep harmony`

# destructuring
Quickly creates variables out of array and object values

`var [a,b,c] = ['one', 'two', 'three']` effectively gives you
`var a='one';   var b='two';   var c='three'`

# let, const
`let` gives you block scope for variables
`const` gives you protection against reference re-assignment

# spread
1. For spreading out an array argument across a functions arguments

    ```javascript
    function myFn(arg1, arg2, arg3) {
    
    }
    var ar = [1, 2, 3]
    ```
    `myFn(...ar)` gives `arg1==1, arg2==2, arg3==3`

1. Used with destructuring

    `var [a, b, ...theRest] = [1, 2, 3, 4]`
    gives `theRest === [3, 4]`

1. To merge collections

    `var ar = [1, 2, 3]`
    `var expandedAr = ['a', 'b', ...ar, 'c']` gives `['a', 'b', 1, 2, 3, 'c']`
