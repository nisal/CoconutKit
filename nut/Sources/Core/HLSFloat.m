//
//  HLSFloat.m
//  nut
//
//  Created by Samuel Défago on 9/19/10.
//  Copyright 2010 Hortis. All rights reserved.
//

#import "HLSFloat.h"

#import "HLSAssert.h"

/**
 * For a discussion of float comparison functions, see
 *   http://www.cygnus-software.com/papers/comparingfloats/comparingfloats.htm
 *
 *
 * TODO: Warning: Might be unsafe (maybe safe, I think asserting that the sizes are the same should suffice to make it safe), see:
 *           http://blog.llvm.org/2011/05/what-every-c-programmer-should-know_21.html
 *           http://labs.qt.nokia.com/2011/06/10/type-punning-and-strict-aliasing/
 *           http://cellperformance.beyond3d.com/articles/2006/06/understanding-strict-aliasing.html)
 *
 *       Possible solution:
 *           http://en.wikipedia.org/wiki/Unit_in_the_last_place
 */

BOOL floateq_dist(float x, float y, int32_t maxDist)
{
    HLSStaticAssert(sizeof(float) == sizeof(int32_t));
    
    int32_t i_x = *(int32_t *)&x;
    if (i_x < 0) {
        i_x = 0x80000000L - i_x;
    }
    
    int32_t i_y = *(int32_t *)&y;
    if (i_y < 0) {
        i_y = 0x80000000L - i_y;
    }
    
    return(abs(i_x - i_y) <= maxDist);
}

BOOL doubleeq_dist(double x, double y, int64_t maxDist)
{
    HLSStaticAssert(sizeof(double) == sizeof(int64_t));
    
    int64_t i_x = *(int64_t *)&x;
    if (i_x < 0) {
        i_x = 0x8000000000000000LL - i_x;
    }
    
    int64_t i_y = *(int64_t *)&y;
    if (i_y < 0) {
        i_y = 0x8000000000000000LL - i_y;
    }
    
    return(llabs(i_x - i_y) <= maxDist);
}

float floatmin_dist(float x, float y, int32_t maxDist)
{
    return floatlt_dist(x, y, maxDist) ? x : y;
}

float floatmax_dist(float x, float y, int32_t maxDist)
{
    return floatlt_dist(x, y, maxDist) ? y : x;
}

double doublemin_dist(double x, double y, int64_t maxDist)
{
    return doublelt_dist(x, y, maxDist) ? x : y;
}

double doublemax_dist(double x, double y, int64_t maxDist)
{
    return doublelt_dist(x, y, maxDist) ? y : x;
}
