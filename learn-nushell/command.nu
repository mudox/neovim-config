def greet [name, --flag (-f): int] {
  [$name $flag] | to nuon
}

greet hi | print

let a = 1
print $a

let a = 'a'
print $a
