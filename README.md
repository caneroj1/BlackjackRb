BlackjackRb
===========

Repo for playing blackjack in ruby

<h3>this code will suffice for displaying cards for now</h3>
```
table = TTY::Table.new [["5 \xE2\x99\xA5"]]
puts table.render(:ascii, multiline: true, width: 10, resize: true) { |renderer| renderer.padding= [1, 1, 1, 2] }
```

<h3>utf-8 encodings of suits</h3>

<p>black heart:</p>
`\xE2\x99\xA5`
<br>
<p>&#9829;</p>

<p>white heart:</p>
`\xE2\x99\xA1`
<br>
<p>&#9825;</p>

<p>
black spade:</p>
`\xE2\x99\xA0`
<br>
<p>&#9824;</p>

<p>white spade:</p>
`\xE2\x99\xA4`
<br>
<p>&#9828;</p>

<p>black diamond:</p>
`\xE2\x99\xA6`
<br>
<p>&#9830;</p>

<p>white diamond:</p>
`\xE2\x99\xA2`
<br>
<p>&#9826;</p>

<p>black club:</p>
`\xE2\x99\xA3`
<br>
<p>&#9827;</p>

<p>white club:</p>
`\xE2\x99\xA7`
<br>
<p>&#9831;</p>
