# SWAPP
Script to find movies in common between to Star Wars characters

## Requirements
* Ruby (this script has only been tested with version 2.4.1)

## How to use
To use you only neet to execute and pass two arguments which should be characters in Star Wars. For example:
```
$> ruby swapp.rb luke leia
```
or
```
$> ./swapp.rb yoda "han solo"
```

## Output
The script will print the titles of the movies where they both appeared. For example:
```
$> ruby swapp luke leia
The Empire Strikes Back
Revenge of the Sith
Return of the Jedi
A New Hope
The Force Awakens
```

## Testing
To run the unit tests for the script execute **swapp_test.rb** in the same directory. For example:
```
$> ruby swapp_test.rb
```
or
```
$> ./swapp_test.rb
```