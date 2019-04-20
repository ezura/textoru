import Foundation
import SwiftSyntax
import Files

enum StringSyntaxFamily {
    case stringLiteralSyntax(StringLiteralExprSyntax)
    case stringInterpolationExprSyntax(StringInterpolationExprSyntax)
    
    var text: String {
        switch self {
        case .stringLiteralSyntax(let syntax):
            return syntax.stringLiteral.withoutTrivia().text
        case .stringInterpolationExprSyntax(let syntax):
            return syntax.segments.map {
                $0.description
            }.joined()
        }
    }
}

class TextVisitor: SyntaxVisitor {
    typealias OnFoundBlock = (StringSyntaxFamily) -> Void
    let onFound: OnFoundBlock
    
    init(onFound: @escaping OnFoundBlock) {
        self.onFound = onFound
    }
    
    override func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
        onFound(.stringLiteralSyntax(node))
        return super.visit(node)
    }
        
    override func visit(_ node: StringInterpolationExprSyntax) -> SyntaxVisitorContinueKind {
        onFound(.stringInterpolationExprSyntax(node))
        return .skipChildren
    }
}

class FileVisitor {
    typealias OnFoundBlock = (File) -> Void
    
    func visit(directoryOrFilePath rootPath: String, fileExtension: String, onFound: OnFoundBlock) {
        let currentFolder = FileSystem().currentFolder
        
        if let folder = try? currentFolder.subfolder(atPath: rootPath) {
            for file in folder.makeFileSequence(recursive: true, includeHidden: false) where file.extension == fileExtension {
                onFound(file)
            }
        } else if let file = try? currentFolder.file(atPath: rootPath) {
            onFound(file)
        } else {
            print("error: \(rootPath) is not found.")
        }
    }
}

class TextFounder {
    var texts: [StringSyntaxFamily] = []
    
    func run(file: File) {
        let fileURL = URL(fileURLWithPath: file.path)
        let syntaxTree = try! SyntaxTreeParser.parse(fileURL)
        
        let textVisitor = TextVisitor { [unowned self] (syntax) in
            self.texts.append(syntax)
        }
        syntaxTree.walk(textVisitor)
        dump(texts.map { $0.text })
    }
}

FileVisitor().visit(directoryOrFilePath: "./Tests/textoruTests/", fileExtension: "swift") { (file) in
    TextFounder().run(file: file)
}

FileVisitor().visit(directoryOrFilePath: "./Tests/textoruTests/", fileExtension: "xib") { (file) in
    TextVisitorForXIB().visit(file: file)
}
