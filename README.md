# textoru

This tool can extract texts from swift code, xib and storyboard.  
Let's run `textoru {path of file or directory}`!

## Output
### format
```
{filename}    {line}:{column}    {text}
```

### Sample output
```
textoruTests.swift    31:15    prefix_____\(pipe)_____suffix
textoruTests.swift    37:75    .xctest
textoruTests.swift    40:20    couldn't find the products directory
textoruTests.swift    47:10    testExample
textoruTests.xib    18:360    Label のテキスト
textoruTests.xib    32:61    Button のテキスト
textoruTests.storyboard    20:372    Label のテキスト
textoruTests.storyboard    34:73    Button のテキスト
```

## Discuss

I want to distinguish the output of Raw strings(`#"{ text }"#`) and normal string clearly.
So the output of Raw strings is not trimmed with "#".
