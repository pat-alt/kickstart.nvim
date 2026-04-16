"""
    mysum(a, b)

Compute and return the sum of `a` and `b`.

# Arguments
- `a`: First addend.
- `b`: Second addend.

# Returns
- The sum `a + b`.

# Examples
```jldoctest
julia> mysum(2, 3)
5
```
"""
function mysum(a, b)
    return a + b
end

"""
    myprod(arguments)

Compute the product of all elements in `arguments`.

# Arguments
- `arguments`: An iterable collection of numeric values.

# Returns
- The product of all elements in `arguments`.

# Examples
```jldoctest
julia> myprod([1, 2, 3, 4])
24
```
"""
function myprod(arguments)
    return prod(arguments)
end
