# textoru

A description of this package.

## First step
`swift package init --type executable`

write dependencies
neet to add following config. if it is not written, failt at installing by mint.
```
products: [
.executable(name: "textoru", targets: ["textoru"])
],
```

`swift build`
resolve dependencies

We can run comment
`./.build/x86_64-apple-macosx/debug/textoru`
> Hello, world!

お好みで
`swift package generate-xcodeproj`
