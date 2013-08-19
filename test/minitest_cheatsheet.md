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

### Helpers

* [Let](#let)
* [Subject](#subject)
* [Specify](#specify)
* [Skip](#skip)

### Mocks

* [Mocks](#mocks)

#### Notes:

Official Docs for [Minitest](http://www.ruby-doc.org/stdlib-2.0/libdoc/minitest/spec/rdoc/), [Minitest Spec](http://www.ruby-doc.org/stdlib-2.0/libdoc/minitest/rdoc/MiniTest.html) and [Minitest Mocks](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/minitest/mock/rdoc/MiniTest/Mock.html)

[Minitest Github Repo](https://github.com/seattlerb/minitest)

[Minimalicious Testing](http://blog.arvidandersson.se/2012/03/28/minimalicous-testing-in-ruby-1-9)

[Minitest Quick Reference](http://mattsears.com/articles/2011/12/10/minitest-quick-reference)

[Minitest Cheat Sheet, Unit and Spec reference](http://danwin.com/2013/03/ruby-minitest-cheat-sheet/)


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

Helpers
-------


## Let

`let` is like simplified version of the before hook that you use to setup predefined accessors and the values they return:

		describe Person do

		  let(:person) { Person.new("Yukihiro", "Matsumoto") }

		  it "has a full name" do
		    person.full_name.must_equal "Yukihiro Matsumoto"
		  end

		end

## Subject

`subject` works similar to let but you can only use it to set a accessor called subject. This is used to specify the object who's behavior is being described:

		describe Person do

		  subject { Person.new("Yukihiro", "Matsumoto") }

		  it "has a full name" do
		    subject.full_name.must_equal "Yukihiro Matsumoto"
		  end

		end

## Specify

`specify` is a alias for `it`, it is usually used where it doesn't make sense to describe the example with a string:

		describe Person do

		  subject { Person.new }

		  specify { subject.posts.must_be_empty }

		end

## Skip

`skip` provides a way to skip examples from being run, the method takes a string as optional argument that can be used to provide a explanation to why that example is skipped:

		describe Ticket do

		  it "expires after one year" do
		    skip "Vending machine clock is broken"
		    t = Ticket.new(:created_at => 1.year_ago)
		    t.expired?.must_be true
		  end

		end

The code after skip is not run in the example and is reported as “Skipped” (a S instead of a .) in the output when running the tests:

		$ ruby spec/ticket_spec.rb
		Run options: --seed 48730

		# Running tests:

		S

		Finished tests in 0.000633s, 1579.7788 tests/s, 0.0000 assertions/s.

		1 tests, 0 assertions, 0 failures, 0 errors, 1 skips

This can be handy if you want to hide error messages while doing refactorings or to describe a bug that you are not going to fix this very minute.

Another way of doing skips is using the it method without a block. This can be used to keep a list of tests that you plan to write. As skipped tests gets marked in the output you will get reminded that there are examples left to write.

		describe Ticket do

		  it "expires after one year"
		  it "has a description"
		  it "belongs to a venue"

		end

## Mocks

Todo.