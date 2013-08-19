Minitest Cheatsheet
===================

## Table of Contents

* [Empty](#empty)
* [Equal](#equal)
* [Delta](#delta)
  * [Close to](#close-to-alternate-delta-syntax)
* [Epsilon](#epsilon)
* [Includes](#includes)
* [Instance Of](#instance-of)
* [Kind Of](#kind-of)
* [Match](#match)
* [Nil](#nil)
* [Operator](#operator)
* [Output](#output)
* [Raises](#raises)
* [Respond To](#respond-to)
* [Same](#same)
* [Silent](#silent)
* [Throws](#throws)

### Setup

* [Test Setup](#test-setup)
* [Test Teardown](#test-teardown)

## Empty


Unit: `assert_empty`, `refute_empty`

Spec: `must_be_empty`, `wont_be_empty`

Arguments: `obj, msg=nil`

Examples:

    assert_empty []
    refute_empty [1,2,3]
    [].must_be_empty
    [1,2,3].wont_be_empty


## Equal

Unit: `assert_equal`, `refute_equal`

Spec: `must_equal`, `wont_equal`

Arguments: `exp, act, msg=nil`

Examples:

    assert_equal 2, 2
    refute_equal 2,1
    2.must_equal 2
    2.wont_equal 1

## Delta

Unit: `assert_in_delta`, `refute_in_delta`

Spec: `must_be_within_delta`, `wont_be_within_delta`

Arguments: `exp, act, dlt=0.001, msg=nil`

Examples:

    assert_in_delta 2012, 2010, 2
    refute_in_delta 2012, 3012, 2
    2012.must_be_within_delta 2010, 2
    2012.wont_be_within_delta 3012, 2

### Close to (alternate Delta syntax)

Spec: `must_be_close_to`, `wont_be_close_to`

Arguments: `act, dlt=0.001, msg=nil`

Examples:

    2012.must_be_close_to 2010, 2
    2012.wont_be_close_to 3012, 2

## Epsilon

Unit: `assert_in_epsilon`, `refute_in_epsilon`

Spec: `must_be_within_epsilon`, `wont_be_within_epsilon`

Arguments: `a, b, eps=0.001, msg=nil`

Examples:

    assert_in_epsilon 1.0, 1.02, 0.05
    refute_in_epsilon 1.0, 1.06, 0.05
    1.0.must_be_within_epsilon 1.02, 0.05
    1.0.wont_be_within_epsilon 1.06, 0.05

## Includes

Unit: `assert_includes`, `refute_includes`

Spec: `must_include`, `wont_include`

Arguments: `collection, obj, msg=nil`

Examples:

    assert_includes [1, 2], 2
    refute_includes [1, 2], 3
    [1, 2].must_include 2
    [1, 2].wont_include 3

## Instance Of

Unit: `assert_instance_of`, `refute_instance_of`

Spec: `must_be_instance_of`, `wont_be_instance_of`

Arguments: `klass, obj, msg=nil`

Examples:

    assert_instance_of String, "bar"
    refute_instance_of String, 100
    "bar".must_be_instance_of String
    100.wont_be_instance_of String

## Kind Of

Unit: `assert_kind_of`, `refute_kind_of`

Spec: `must_be_kind_of`, `wont_be_kind_of`

Arguments: `klass, obj, msg=nil`

Examples:

    assert_kind_of Numeric, 100
    refute_kind_of Numeric, "bar"
    100.must_be_kind_of Numeric
    "bar".wont_be_kind_of Numeric

## Match

Unit: `assert_match`, `refute_match`

Spec: `must_match`, `wont_match`

Arguments: `exp, act, msg=nil`

Examples:

    assert_match /\d/, "42"
    refute_match /\d/, "foo"
    "42".must_match /\d/
    "foo".wont_match /\d/

## Nil

Unit: `assert_nil`, `refute_nil`

Spec: `must_be_nil`, `wont_be_nil`

Arguments: `obj, msg=nil`

Examples:

    assert_nil [].first
    refute_nil [1].first
    [].first.must_be_nil
    [1].first.wont_be_nil

## Operator

Unit: `assert_operator`, `refute_operator`

Spec: `must_be`, `wont_be`

Arguments: `o1, op, o2, msg=nil`

Examples:

   assert_operator 1, :<, 2
   refute_operator 1, :>, 2
   1.must_be :<, 2
   1.wont_be :>, 2

## Output

Unit: `assert_output`

Spec: `must_output`

Arguments: `stdout = nil, stderr = nil`

Examples:

    assert_output("hi\n"){ puts "hi" }
    Proc.new{puts "hi"}.must_output "hi\n"

## Raises

Unit: `assert_raises`

Spec: `must_raise`

Arguments `*exp`

Examples:

    assert_raises(NoMethodError){ nil! }
    Proc.new{nil!}.must_raise NoMethodError

## Respond To

Unit: `assert_respond_to`, `refute_respond_to`

Spec: `must_respond_to`, `wont_respond_to`

Arguments: `obj, meth, msg=nil`

Examples:

    assert_respond_to "foo",:empty?
    refute_respond_to 100, :empty?
    "foo".must_respond_to :empty?
    100.wont_respond_to :empty?

## Same

Unit: `assert_same`, `refute_same`

Spec: `must_be_same_as`, `wont_be_same_as`

Arguments: `exp, act, msg=nil`

Examples: 

    assert_same :foo, :foo
    refute_same ['foo'], ['foo']
    :foo.must_be_same_as :foo
    ['foo'].wont_be_same_as ['foo']

## Silent

Unit: `assert_silent`

Spec: `must_be_silent`

Arguments: none

Examples: 
    
    assert_silent{ 1 + 1 }
    Proc.new{ 1 + 1}.must_be_silent

## Throws

Unit: `assert_throws`

Spec: `must_throw`

Arguments: `sym, msg=nil`

Examples:
   
    assert_throws(:up){ throw :up}
    Proc.new{throw :up}.must_throw :up


Test Setup
-----------

Unit: `setup()`

Spec: `before(type = nil, &block)`

Test Teardown
-------------

Unit: `teardown()`

Spec: `after(type = nil, &block)`
