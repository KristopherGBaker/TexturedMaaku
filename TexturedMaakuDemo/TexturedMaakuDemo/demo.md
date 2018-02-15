## TexturedMaaku Demo

# This is a level 1 header.

This is also a level 1 header.
=========

## This is a level 2 header.

This is also a level 2 header.
---------

### This is a level 3 header.

#### This is a level 4 header.

##### This is a level 5 header.

###### This is a level 6 header.

---

Footnotes[^1] are added in-text like so ...

1. item one
2. item two
   - sublist
   - sublist

*Italic* _Italic_

**Bold** __Bold__

***

[Link](http://github.com)

[Link][1]

This is a paragraph with text.

[1]: http://google.com

> blockquote
> > nested blockquote
> > nested test test blockquote
>
> ***
> back to first level

`Inline code` with backticks

```
# code block
print '3 backticks or'
print 'indent 4 spaces'
```

    # code block
    print '3 backticks or'
    print 'indent 4 spaces'

```swift
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription
 
struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription
```

# 雪. Circle header.

| Left-aligned | Center-aligned | Right-aligned |
| :---         |     :---:      |          ---: |
| git status   | git status     | git status    |
| git diff     | git diff       | git diff      |

> | Left | Center | Right |
> | :---         |     :---:      |          ---: |
> | git status   | git status     | git status    |
> | git diff     | git diff       | git diff      |

~~strikethrough~~

> ## This is a header.
>
> 1.   This is the first list item.
> 2.   This is the second list item.
>
> Here's some example code:
>
>     return shell_exec("echo $input | $markdown_script");

![random image](https://ep1.pinkbike.org/p5pb15465155/p5pb15465155.jpg)

![random image](https://lorempixel.com/200/100/)

test@test.com

*   A list item with a blockquote:
    > This is a blockquote
    > inside a list item.

[^1]: Footnotes are the mind killer.
