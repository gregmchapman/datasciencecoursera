makeCacheMatrix <- function(x = matrix()) {
    # returns a cacheMatrix psuedo object, a list of 'methods' acting
    # on the 'members' matX and inverse; allows for inverse to be cached
    # rather than recomputed
    # expects that matX is a square matrix, but does not check - user beware
    
    matX <- x # just being explicit, now both members (matX and inverse) are
              # treated the same. (alternatively, we could have made inverse an
              # optional argument to makeCacheMatrix()
    inverse <- NULL
    
    set <- function(matY) {
        # same caveat as the parent function - user should ensure matY is square
        matX <<- matY
        # reset inverse to null because the matrix is no longer the same
        # one the inverse was computed on
        inverse <<- NULL
    }
    
    get <- function() { matX }
    
    setinverse <- function(solved) { inverse <<- solved } # I cringe that this isn't private
    
    getinverse <- function() { inverse }
    
    #what we're returning
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}


cacheSolve <- function(cMatX) {
    # Return a matrix that is the inverse of cMatX, updating cMatX if neccessary
    # cMatX should be a list of the sort returned by makeCacheMatrix()
    # ... extra arguments are intentionally excluded to ensure the computation
    #     is what we expect, i.e. computing the inverse
    # I would rename the function cacheInverse(), but the assignment expects
    #     cacheSolve()
    
    
    inverse <- cMatX$getinverse()
    
    # check if we can skip the computation
    if(!is.null(inverse)) {
        message("getting cached data") 
        return(inverse)
    }
    
    # if we haven't skipped the computation, let's get it over with
    matX <- cMatX$get()
    inverse <- solve(matX)
    cMatX$setinverse(inverse)
    inverse
}
