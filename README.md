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

## Feature for Xcode
Show warning highlight on Xcode when run this command with `-h=true` at run script.  
Let's run `textoru -h=true {path of file or directory}` at run script!

<img width="1041" alt="スクリーンショット 2019-04-20 18 06 04" src="https://user-images.githubusercontent.com/2020337/56455271-42984e00-6397-11e9-8f87-0defd55a07dc.png">

## Usage

```
USAGE: textoru [option] path

OPTIONS:
  --highlight, -h   show warning highlight on Xcode when run this command at run script.
  --help            Display available options

POSITIONAL ARGUMENTS:
  path              input file/directory path
```

## Discuss

I want to distinguish the output of Raw strings(`#"{ text }"#`) and normal string clearly.
So the output of Raw strings is not trimmed with "#".
