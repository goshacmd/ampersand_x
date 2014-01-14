# &X

Ruby procs can be tiresome. &X (read as "ampersand ex") is a gem to vastly
simplify this and bring expressiveness back to your code.

You'd use &X in places where you need a simple proc, but are too lazy to
type `{ |some_object| some_object.property.another > 42 }` yourself.

There is `&:method_name`, but it wouldn't work with method chains and
arguments to each one. &X tries to fill the gap here.

```ruby
Person = Stuct.new(:first, :age)

patrick = Person.new("Patrick", 19)
jane = Person.new("Jane", 21)
jack = Person.new("Jack", 20)
donald = Person.new("Donald", 25)

people = [patrick, jane, jack, donald]

# plain ruby
people.partition { |person| person.age > 20 }

# with &X
people.partition(&X.age > 20)
```

You can traverse a long chain of properties as well.

```ruby
# Suppose we have a Person class with +address+ property,
# which, in turn, has +city+ and +street+ properties.
# We want to find all people older than 20 living in Chicago...

# plain ruby
people.select { |person| person.age > 20 && person.address.city == "Chicago" }

# &X
people.select(&X.age > 20).select(&X.address.city == "Chicago")
```

## Installation

Add this line to your application's Gemfile:

    gem 'ampersand_x'

Or install it yourself as:

    $ gem install ampersand_x

## License

[MIT](LICENSE).
